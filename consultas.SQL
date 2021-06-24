-- consulta 01 :
-- Mostrar nombre, salario y nombre de la ciudad de los empleados que atendieron órdenes de repuestos o
-- partes recepcionados en enero de 2021 y despachados en febrero de 2021, excluir del reporte los 
-- repuestos que sean engranajes.

SELECT empleados.nombre_empleado, empleados.salario, ciudad.nom_ciudad
from empleados, ciudad, ordenes, repuestos, detalleorden, tipo_de_repuesto
where (ordenes.fecha_rec_emp >= '2021-01-01' and ordenes.FECHA_REC_EMP <= '2021-01-31')
AND (ordenes.FECHA_ENVIO_CLI>='2021-02-01' and ordenes.FECHA_ENVIO_CLI<='2021-02-28')
AND tipo_de_repuesto.NOM_TIPO_REP not like 'engr%'
AND ciudad.id_ciudad = empleados.ID_CIUDAD AND empleados.ID_EMPLEADO = ordenes.ID_EMPLEADO
AND tipo_de_repuesto.COD_TIP_REP = repuestos.COD_TIP_REP AND repuestos.ID_REPUESTOS = detalleorden.ID_REPUESTOS
AND detalleorden.ID_ORDEN = ordenes.ID_ORDEN;

-- consulta 02:
-- Mostrar un listado de los números de orden que contienen los repuestos o partes como ser rodamientos y/o discos
-- de freno, que fueron pedidos en el primer trimestre de 2021, por clientes que viven en Cochabamba y Sacaba.

select ordenes.id_orden
from ordenes, tipo_de_repuesto, repuestos, detalleorden ,clientes, ciudad
where (tipo_de_repuesto.NOM_TIPO_REP like 'rod%' or tipo_de_repuesto.NOM_TIPO_REP like 'disc%')
AND (ordenes.FECHA_REC_EMP >= '2021/01/01' AND ordenes.FECHA_REC_EMP<='2021/03/31')
AND (ciudad.nom_ciudad = 'cbba' or ciudad.nom_ciudad = 'sacaba')
AND tipo_de_repuesto.COD_TIP_REP = repuestos.COD_TIP_REP AND repuestos.ID_REPUESTOS = detalleorden.ID_REPUESTOS
AND detalleorden.ID_ORDEN = ordenes.ID_ORDEN
AND ciudad.id_ciudad = clientes.ID_CIUDAD AND clientes.id_cliente = ordenes.ID_CLIENTE;

-- consulta 03:
-- Por cada tipo de repuesto mostrar el promedio de existencia de cada
-- tipo de repuesto, la cantidad de repuesto de cada tipo, pero solo de
-- aquellos tipos de repuestos cuyo promedio de existencia sea mayor a 50
-- unidades. Ordenar la salida en forma descendente por la cantidad de
-- repuestos.

select AVG(b.CANT_EX_REP) AS Promedio, a.NOM_TIPO_REP AS Repuesto
FROM tipo_de_repuesto a, repuestos b
where a.COD_TIP_REP = b.COD_TIP_REP
group by a.NOM_TIPO_REP
having AVG(CANT_EXP_REP)>1000
order by sum(CANT_EXP_REP)desc;
