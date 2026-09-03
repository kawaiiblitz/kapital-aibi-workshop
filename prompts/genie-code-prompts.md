# Prompts para Genie Code (crear el dashboard AI/BI)

Genie Code es el modo agente del dashboard: le describes lo que quieres en lenguaje
natural, referencias tus tablas con `@nombre_tabla`, y el agente crea los datasets,
las visualizaciones, el layout y los filtros. Corrige errores solo.

Usa estos prompts en orden. Referencia tus tablas con `@` (Genie las busca en tu esquema).

---

## Prompt 1 — Construir el dashboard base

```
Crea un dashboard de salud de cartera de tarjetas de credito usando @clientes,
@tarjetas y @transacciones. Arriba pon tarjetas de KPI: numero de clientes activos,
limite de credito total otorgado, saldo total utilizado y ticket promedio de
transaccion. Debajo: una grafica de barras de saldo utilizado por tipo de tarjeta,
una de monto transaccionado por categoria, y una linea de monto transaccionado por
fecha en los ultimos 90 dias. Agrega filtros por pais y por segmento de cliente.
```

## Prompt 2 — Agregar una segunda pagina de Cobranza

```
Agrega una segunda pagina llamada Cobranza usando @cobranza y @clientes: un KPI de
monto vencido total, una grafica de monto vencido por tramo de mora, una grafica de
probabilidad de pago promedio por tramo de mora, y una tabla con los 20 clientes de
mayor monto vencido mostrando ciudad, segmento y ultima gestion.
```

## Prompt 3 — Dar formato y pulir

```
Da formato de moneda en pesos a todos los montos, ordena las barras de mayor a menor,
ponle titulos claros en espanol a cada grafica, y usa una paleta de color consistente.
```

## Prompt 4 (opcional) — Deteccion de fraude

```
Agrega una tarjeta de KPI con el monto total de transacciones marcadas como fraude
(es_fraude = true) de @transacciones y una grafica de ese monto por canal.
```

---

## Tip
Si una grafica no salio como esperabas, no la borres: dile a Genie Code el ajuste en
lenguaje natural ("cambia esa grafica a barras horizontales", "agrupa por mes en vez de
por dia"). El agente edita sobre lo que ya existe.
