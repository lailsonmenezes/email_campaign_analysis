# 📧 Email Campaign Performance Analysis

Análise desenvolvida utilizando Google BigQuery para consolidar métricas de campanhas de e-mail, combinando informações de contas, envios, aberturas e visitas. O projeto utiliza SQL avançado para transformar dados brutos em indicadores de desempenho por país.

# 📌 Sobre o Projeto

O objetivo do projeto é consolidar informações provenientes de diferentes tabelas relacionais para gerar métricas capazes de avaliar o desempenho de campanhas de e-mail.

Os dados originais continham informações distribuídas entre diversas tabelas, tornando inviável uma análise direta. Para solucionar esse problema, foram utilizadas Common Table Expressions (CTEs), agregações e Window Functions para estruturar os dados em um formato analítico.

Ao final da consulta é possível identificar, para cada país, indicadores como quantidade de contas, quantidade de e-mails enviados, abertos e visitados, além de rankings baseados nesses indicadores.

# 🎯 Objetivos

1. Consolidar informações provenientes de múltiplas tabelas relacionais.

2. Construir métricas referentes ao desempenho das campanhas de e-mail.

3. Aplicar técnicas avançadas de SQL para transformar dados brutos em indicadores analíticos.

4. Gerar rankings dos países com maior quantidade de contas cadastradas e maior volume de e-mails enviados.

---

# 📂 Fonte dos Dados

**Origem:**

Base de dados disponibilizada em ambiente de treinamento do Google BigQuery.

**Observação:**

Os dados utilizados neste projeto não podem ser disponibilizados publicamente. Por esse motivo, este repositório contém apenas a consulta SQL desenvolvida e o resultado final exportado da análise.

---

# 🛠 Ferramentas Utilizadas

- Google BigQuery
- SQL
- Git
- GitHub

---

# 📑 Consulta SQL Desenvolvida

## Objetivo

A consulta foi construída utilizando diversas Common Table Expressions (CTEs), onde cada etapa possui uma responsabilidade específica dentro da transformação dos dados.

Inicialmente são criadas métricas referentes às contas cadastradas e às campanhas de e-mail. Posteriormente essas informações são consolidadas através de um `UNION ALL`, agregadas por país e complementadas utilizando Window Functions para calcular totais e gerar rankings.

Ao final da consulta são retornados apenas os dez países com maior quantidade de contas cadastradas ou maior volume de e-mails enviados.

### Técnicas utilizadas

- Common Table Expressions (CTEs)
- LEFT JOIN
- UNION ALL
- Aggregate Functions
- GROUP BY
- SUM()
- COUNT(DISTINCT)
- Window Functions
- DENSE_RANK()
- CASE
- DATE_ADD()

### Resultado

*(Imagem da execução da consulta)*

---

# 💡 Principais Métricas

A consulta produz os seguintes indicadores:

- Número de contas cadastradas.
- Quantidade de e-mails enviados.
- Quantidade de e-mails abertos.
- Quantidade de visitas provenientes dos e-mails.
- Total de contas por país.
- Total de e-mails enviados por país.
- Ranking dos países com maior número de contas.
- Ranking dos países com maior quantidade de e-mails enviados.

---

# 📁 Estrutura do Repositório

```text
Email-Campaign-Analysis
│
├── data
│   └── email_campaign_metrics.csv
│
├── images
│   └── query_result.png
│
├── sql
│   └── email_campaign_analysis.sql
│
└── README.md
```

---

# 🚀 Habilidades Demonstradas

- SQL
- Google BigQuery
- Data Transformation
- Data Aggregation
- JOINs
- Common Table Expressions (CTEs)
- Window Functions
- Aggregate Functions
- Ranking
- Business Analytics
- Git
- GitHub

---

- # 👨‍💻 Autor

Lailson de Menezes

[LinkedIn](https://www.linkedin.com/in/lailson-menezes-910908365/)

[GitHub](https://github.com/lailsonmenezes)
