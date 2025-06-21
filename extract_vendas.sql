| CATEGORIA           | Exemplos                            | Final                                              |
| ------------------- | ----------------------------------- | -------------------------------------------------- |
| `YEAR`              | `EXTRACT(YEAR FROM data_coleta)`    | `2025`                                             |
| `MONTH`             | `EXTRACT(MONTH FROM data_coleta)`   | `5`                                                |
| `DAY`               | `EXTRACT(DAY FROM data_coleta)`     | `14`                                               |
| `HOUR`              | `EXTRACT(HOUR FROM data_coleta)`    | `16`                                               |
| `MINUTE`            | `EXTRACT(MINUTE FROM data_coleta)`  | `30`                                               |
| `SECOND`            | `EXTRACT(SECOND FROM data_coleta)`  | `45`                                               |
| `DOW` (Day of Week) | `EXTRACT(DOW FROM data_coleta)`     | `2` (0 = domingo, 1 = segunda, 2 = terça...)       |
| `DOY` (Day of Year) | `EXTRACT(DOY FROM data_coleta)`     | `135` (135º dia do ano)                            |
| `WEEK`              | `EXTRACT(WEEK FROM data_coleta)`    | `20` (20ª semana do ano)                           |
| `QUARTER`           | `EXTRACT(QUARTER FROM data_coleta)` | `2` (segundo trimestre)                            |

---

### exemplo:

#### Verificar dodos de abril:

```sql
SELECT *
FROM tabela
WHERE EXTRACT(MONTH FROM data_coleta) = 4;
```

#### filtrar dados do fim de semana (sábado e domingo):

```sql
SELECT *
FROM tabela
WHERE EXTRACT(DOW FROM data_coleta) IN (0, 6);
```

#### agrupamento por trimestre:

```sql
SELECT EXTRACT(QUARTER FROM data_coleta) AS trimestre, COUNT(*)
FROM tabela
GROUP BY trimestre;
```
