# Normaliza-tu-mundo-de-datos

1¿Qué problema principal busca resolver la normalización en una base de datos y por qué es crítica en sistemas empresariales?
Problema Principal:Eliminar la redundancia de datos (repetición innecesaria) y evitar las anomalías (errores/inconsistencias al insertar, actualizar o eliminar datos).
Crítica Empresarial:Asegurar la integridad y consistencia de la información. Esto es vital para la fiabilidad de las operaciones, la contabilidad y la toma de decisiones empresariales.

2.Describe con tus propias palabras las diferencias entre 1NF, 2NF y 3NF según los ejemplos del artículo.

°1NF	(Valores atómicos y sin grupos repetidos):Asegura que cada celda contenga solo un valor y que las listas de valores estén separadas en filas o tablas.
°2NF	(Estar en 1NF + Eliminar Dependencias Parciales):Asegura que todos los atributos no clave dependan de toda la clave primaria.
°3NF	(Estar en 2NF + Eliminar Dependencias Transitivas):Asegura que ningún atributo no clave dependa de otro atributo no clave; todos deben depender solo de la clave primaria.

3.En los ejemplos de Devart, identifica una situación donde la normalización mejora la integridad de datos, pero podría afectar el rendimiento. Explica el motivo.

°Mejora la Integridad-Sí, al garantizar que los datos estén en un solo lugar y sean coherentes.
°Afecta el Rendimiento-Podría afectarlo negativamente en las consultas de lectura (SELECT).
°Motivo: La información se separa en muchas tablas, obligando al sistema a realizar múltiples y costosas operaciones de JOIN (unión) para reconstruir los datos completos.

4.¿Qué papel juegan las dependencias funcionales en el proceso de normalización y cómo las identificarías en una tabla?

Las dependencias funcionales son cruciales en la normalización porque identifican relaciones entre atributos para minimizar la redundancia y mejorar la integridad de los datos. Para identificarlas en una tabla, se debe buscar un atributo o conjunto de atributos que determine de forma única a otro atributo; por ejemplo, si el valor de ID_Estudiante siempre corresponde a un único Nombre_Estudiante, existe una dependencia funcional entre ID_Estudiante y Nombre_Estudiante

5.Explica, con tus palabras, cuándo sería justificable “desnormalizar” una base de datos según el contexto de negocio.

Sacrificamos la limpieza de la base de datos y aumentamos el riesgo de inconsistencia para que la aplicación sea más rápida y eficiente al momento de leer o mostrar datos.

FREDS FURNITURE

°Datos repetidos en los registros de ventas el nombre del cliente se repetía en cada venta.
°Dependencias parciales, ya que algunos datos dependían solo de parte de una clave compuesta.
°Ausencia de categorías separadas para los productos los tipos de muebles estaban mezclados en una sola tabla.
°No había llaves foráneas definidas entre tablas relacionadas.

DIAGRAMA ER
https://dbdiagram.io/d/690430986735e1117098d69e

<img width="1077" height="548" alt="image" src="https://github.com/user-attachments/assets/41157810-74d7-490e-a050-3b97920cadf6" />


