# Databricks notebook source
# MAGIC %md
# MAGIC # Taller AI/BI - Cargar datos desde CSV
# MAGIC
# MAGIC Alternativa al notebook `00_setup_datos.sql`. En vez de generar la data con SQL,
# MAGIC este notebook **lee los CSV que vienen en el repo** (carpeta `data/`) y crea las
# MAGIC mismas 4 tablas. Los datos son identicos para todos (deterministas).
# MAGIC
# MAGIC ## Antes de correr
# MAGIC 1. Adjunta compute (un cluster o serverless).
# MAGIC 2. Ajusta `CATALOGO` e `INICIALES` en la celda de abajo.
# MAGIC 3. Run all.

# COMMAND ----------

CATALOGO = "main"          # cambia si no tienes permiso de CREATE (FEVM: serverless_stable_rtpa_catalog)
INICIALES = "rp"           # tus iniciales, para no chocar con tus companeros
SCHEMA = f"taller_aibi_{INICIALES}"

spark.sql(f"CREATE SCHEMA IF NOT EXISTS {CATALOGO}.{SCHEMA}")
print(f"Cargando en {CATALOGO}.{SCHEMA}")

# COMMAND ----------

import os
import pandas as pd
from pyspark.sql.functions import to_date, col

# la carpeta data/ esta un nivel arriba de notebooks/ dentro del repo clonado
DATA = os.path.join(os.path.dirname(os.getcwd()), "data")

# columnas de fecha por tabla (para no dejarlas como texto)
FECHAS = {
    "clientes": ["fecha_alta"],
    "tarjetas": ["fecha_emision"],
    "transacciones": ["fecha"],
    "cobranza": [],
}

for tabla, cols_fecha in FECHAS.items():
    pdf = pd.read_csv(f"{DATA}/{tabla}.csv")
    df = spark.createDataFrame(pdf)
    for c in cols_fecha:
        df = df.withColumn(c, to_date(col(c)))
    df.write.mode("overwrite").saveAsTable(f"{CATALOGO}.{SCHEMA}.{tabla}")
    print(f"  {tabla}: {df.count()} filas")

print("Listo.")

# COMMAND ----------

# MAGIC %md
# MAGIC ## Verifica

# COMMAND ----------

display(spark.sql(f"""
SELECT 'clientes' AS tabla, count(*) AS filas FROM {CATALOGO}.{SCHEMA}.clientes
UNION ALL SELECT 'tarjetas', count(*) FROM {CATALOGO}.{SCHEMA}.tarjetas
UNION ALL SELECT 'transacciones', count(*) FROM {CATALOGO}.{SCHEMA}.transacciones
UNION ALL SELECT 'cobranza', count(*) FROM {CATALOGO}.{SCHEMA}.cobranza
ORDER BY tabla
"""))
