
/*
Project: Email Campaign Analysis

Description:
This query consolidates account and email metrics,
calculates country-level aggregates,
and ranks countries using window functions.

Author: Lailson de Menezes
*/


WITH
  account_metrics AS (
    SELECT
      s.date AS date,
      sp.country AS country,
      acc.send_interval AS send_interval,
      acc.is_verified AS is_verified,
      acc.is_unsubscribed AS is_unsubscribed,
      count(DISTINCT acc.id) AS account_cnt,
      0 AS open_msg,
      0 AS sent_msg,
      0 AS visit_msg
    FROM
      `DA.account` AS acc
      LEFT JOIN `DA.account_session` acs ON acc.id = acs.account_id
      LEFT JOIN `DA.session_params` AS sp ON acs.ga_session_id = sp.ga_session_id
      LEFT JOIN `DA.session` AS s ON acs.ga_session_id = s.ga_session_id
    GROUP BY
      1,
      2,
      3,
      4,
      5
  ),
  email_metrics AS (
    SELECT
      date_add(s.date, interval es.sent_date day) AS date,
      sp.country AS country,
      acc.send_interval AS send_interval,
      acc.is_verified AS is_verified,
      acc.is_unsubscribed AS is_unsubscribed,
      0 AS account_cnt,
      count(DISTINCT eo.id_message) AS open_msg,
      count(DISTINCT es.id_message) AS sent_msg,
      count(DISTINCT ev.id_message) AS visit_msg
    FROM
      `DA.email_sent` AS es
      LEFT JOIN `DA.email_open` AS eo ON es.id_message = eo.id_message
      LEFT JOIN `DA.email_visit` AS ev ON es.id_message = ev.id_message
      LEFT JOIN `DA.account` AS acc ON es.id_account = acc.id
      LEFT JOIN `DA.account_session` AS acs ON acc.id = acs.account_id
      LEFT JOIN `DA.session_params` AS sp ON acs.ga_session_id = sp.ga_session_id
      LEFT JOIN `DA.session` AS s ON acs.ga_session_id = s.ga_session_id
    GROUP BY
      1,
      2,
      3,
      4,
      5
  ),
  union_CTE AS (
    SELECT
      *
    FROM
      account_metrics
    UNION ALL
    SELECT
      *
    FROM
      email_metrics
  ),
  final_group_by AS (
    SELECT
      date,
      country,
      send_interval,
      is_verified,
      is_unsubscribed,
      sum(account_cnt) AS account_cnt,
      sum(sent_msg) AS sent_msg,
      sum(open_msg) AS open_msg,
      sum(visit_msg) AS visit_msg
    FROM
      union_CTE
    GROUP BY
      1,
      2,
      3,
      4,
      5
  ),
  window_function_CTE AS (
    SELECT
      date,
      country,
      send_interval,
      is_verified,
      is_unsubscribed,
      account_cnt,
      sent_msg,
      open_msg,
      visit_msg,
      sum(account_cnt) OVER (
        PARTITION BY
          country
      ) AS total_country_cnt,
      sum(sent_msg) OVER (
        PARTITION BY
          country
      ) AS total_country_sent_cnt
    FROM
      final_group_by
  ),
  window_function_CTE2 AS (
    SELECT
      date,
      country,
      send_interval,
      is_verified,
      is_unsubscribed,
      account_cnt,
      sent_msg,
      open_msg,
      visit_msg,
      total_country_cnt,
      total_country_sent_cnt,
      dense_rank() OVER (
        ORDER BY
          total_country_cnt DESC
      ) AS rank_total_country_account_cnt,
      dense_rank() OVER (
        ORDER BY
          total_country_sent_cnt DESC
      ) AS rank_total_country_sent_cnt
    FROM
      window_function_CTE
  )
SELECT
  date,
  country,
  send_interval,
  CASE
    WHEN is_verified = 1 THEN 'yes'
    ELSE 'no'
  END AS is_verified,
  CASE
    WHEN is_unsubscribed = 1 THEN 'yes'
    ELSE 'no'
  END AS is_unsubscribed,
  account_cnt,
  sent_msg,
  open_msg,
  visit_msg,
  total_country_cnt,
  total_country_sent_cnt,
  rank_total_country_account_cnt,
  rank_total_country_sent_cnt
FROM
  window_function_CTE2
WHERE
  rank_total_country_account_cnt <= 10
  OR rank_total_country_sent_cnt <= 10