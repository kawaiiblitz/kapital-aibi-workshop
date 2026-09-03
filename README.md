# Taller AI/BI en Databricks — Kapital Bank

Material del taller hands-on de **AI/BI Dashboards y Genie**. Todo corre en tu propio
workspace de Databricks con un esquema sintético de banca (clientes, tarjetas,
transacciones, cobranza).

## Contenido

| Ruta | Qué es |
|------|--------|
| `guia/taller-aibi-hands-on.html` | Guía paso a paso (ábrela en el navegador y síguela) |
| `notebooks/00_setup_datos.sql` | Notebook de setup: crea las 4 tablas |
| `prompts/genie-code-prompts.md` | Prompts listos para Genie Code (crear el dashboard) |
| `prompts/genie-space.md` | Instrucciones y preguntas para el Genie Space |

## Cómo empezar (Paso 0)

1. En tu workspace de Databricks, ve a **Workspace > (tu carpeta) > Create > Git folder**
   (o **Repos**).
2. Pega la URL de este repo y clónalo. La primera vez, Databricks te pedirá enlazar una
   **credencial de Git** (un PAT de GitHub): **Settings > Linked accounts / Git integration**.
3. Abre `notebooks/00_setup_datos.sql`, **cambia `rp` por tus iniciales**, adjunta compute
   y da clic en **Run all**.
4. Abre `guia/taller-aibi-hands-on.html` y sigue el taller.

> ¿Sin acceso a Git en el workspace? También puedes copiar el contenido de
> `notebooks/00_setup_datos.sql` directo en el **SQL Editor** y correrlo ahí.

## Agenda

1. Introducción a AI/BI Dashboards y Genie
2. Features y funcionalidades clave
3. Creación de dashboards con Genie Code
4. Creación de espacios de Genie (analítica conversacional)
5. Pruebas de Genie
6. Preguntas
