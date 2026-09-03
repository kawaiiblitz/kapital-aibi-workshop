-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Taller AI/BI - Kapital Bank - Setup de datos
-- MAGIC
-- MAGIC Este notebook crea un esquema sintetico de banca en tu workspace para el taller:
-- MAGIC **clientes**, **tarjetas**, **transacciones** y **cobranza**.
-- MAGIC
-- MAGIC ## Antes de correr
-- MAGIC 1. Adjunta compute arriba a la derecha (un SQL Warehouse serverless o un cluster).
-- MAGIC 2. En la celda de abajo, **cambia `rp` por tus iniciales** en las 3 lineas (evita chocar con tus companeros si comparten catalogo). Puedes usar Edit > Find and Replace.
-- MAGIC 3. Si no tienes permiso de crear esquemas en el catalogo `main`, cambialo por tu catalogo (o pide apoyo al facilitador).
-- MAGIC 4. Da clic en **Run all**. Tarda ~30-60 seg.

-- COMMAND ----------

USE CATALOG main;
CREATE SCHEMA IF NOT EXISTS taller_aibi_rp;
USE SCHEMA taller_aibi_rp;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Clientes (8,000)

-- COMMAND ----------

CREATE OR REPLACE TABLE clientes AS
SELECT
  id AS cliente_id,
  concat('CLI-', lpad(cast(id AS string), 6, '0')) AS codigo_cliente,
  element_at(array('Nomina','Pyme','Premium','Digital','Empresarial'), cast(rand()*5 AS int)+1) AS segmento,
  element_at(array('CDMX','Guadalajara','Monterrey','Puebla','Queretaro','Bogota','Medellin','Cali'), cast(rand()*8 AS int)+1) AS ciudad,
  CASE WHEN rand() < 0.7 THEN 'Mexico' ELSE 'Colombia' END AS pais,
  cast(20 + rand()*45 AS int) AS edad,
  round(8000 + rand()*90000, 0) AS ingreso_mensual,
  date_add(current_date(), -cast(rand()*2000 AS int)) AS fecha_alta,
  element_at(array('Activo','Activo','Activo','Inactivo'), cast(rand()*4 AS int)+1) AS estatus
FROM range(8000);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Tarjetas (10,000)

-- COMMAND ----------

CREATE OR REPLACE TABLE tarjetas AS
SELECT
  tarjeta_id, cliente_id, tipo_tarjeta, limite_credito,
  round(limite_credito * (rand()*0.85), 2) AS saldo_actual,
  fecha_emision, estatus
FROM (
  SELECT
    id AS tarjeta_id,
    cast(rand()*8000 AS int) AS cliente_id,
    -- tipo y limite salen del MISMO indice, para que Signature tenga mas limite que Clasica
    element_at(array('Clasica','Oro','Platino','Signature'), tipo_idx) AS tipo_tarjeta,
    round(element_at(array(15000,40000,90000,200000), tipo_idx) * (0.8 + rand()*0.6), 0) AS limite_credito,
    date_add(current_date(), -cast(rand()*1500 AS int)) AS fecha_emision,
    element_at(array('Vigente','Vigente','Vigente','Bloqueada','Cancelada'), cast(rand()*5 AS int)+1) AS estatus
  FROM (SELECT id, cast(rand()*4 AS int)+1 AS tipo_idx FROM range(10000))
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Transacciones (150,000, ultimos 90 dias)

-- COMMAND ----------

CREATE OR REPLACE TABLE transacciones AS
SELECT
  id AS transaccion_id,
  cast(rand()*10000 AS int) AS tarjeta_id,
  date_add(current_date(), -cast(rand()*90 AS int)) AS fecha,
  round(50 + rand()*rand()*8000, 2) AS monto,
  element_at(array('Supermercado','Restaurantes','Viajes','Gasolina','Retail','Salud','Entretenimiento','Servicios','Educacion'), cast(rand()*9 AS int)+1) AS categoria,
  element_at(array('POS','E-commerce','ATM','App movil','Recurrente'), cast(rand()*5 AS int)+1) AS canal,
  element_at(array('CDMX','Guadalajara','Monterrey','Puebla','Bogota','Medellin'), cast(rand()*6 AS int)+1) AS ciudad,
  CASE WHEN rand() < 0.03 THEN true ELSE false END AS es_fraude
FROM range(150000);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Cobranza (3,000 clientes con mora)

-- COMMAND ----------

CREATE OR REPLACE TABLE cobranza AS
SELECT
  cliente_id,
  dias_mora,
  round(monto_vencido, 2) AS monto_vencido,
  CASE WHEN dias_mora <= 30 THEN '1-30 dias'
       WHEN dias_mora <= 60 THEN '31-60 dias'
       WHEN dias_mora <= 90 THEN '61-90 dias'
       ELSE '90+ dias' END AS tramo_mora,
  round(greatest(0.05, 0.95 - dias_mora/150.0), 2) AS prob_pago,
  element_at(array('Sin gestion','Llamada','SMS','Email','Visita','Acuerdo'), cast(rand()*6 AS int)+1) AS ultima_gestion
FROM (
  SELECT cast(rand()*8000 AS int) AS cliente_id,
         cast(1 + rand()*180 AS int) AS dias_mora,
         500 + rand()*rand()*60000 AS monto_vencido
  FROM range(3000)
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## Verifica que quedaron las 4 tablas

-- COMMAND ----------

SELECT 'clientes' AS tabla, count(*) AS filas FROM clientes
UNION ALL SELECT 'tarjetas', count(*) FROM tarjetas
UNION ALL SELECT 'transacciones', count(*) FROM transacciones
UNION ALL SELECT 'cobranza', count(*) FROM cobranza
ORDER BY tabla;
