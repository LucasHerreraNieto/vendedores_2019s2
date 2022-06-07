import ciudades.*
class CentroDistribucion{
	const vendedores = []
	var property ciudad
	
	method agregarVendedor(unVendedor){
		if(vendedores.contains(unVendedor)){
			
		}
		else{ 
			vendedores.add(unVendedor)
		}
	}
	method vendedorEstrella() = vendedores.max({v=>v.puntajeTotal()})
	method puedeCubrir(unaCiudad) = vendedores.any({v=>v.puedeTrabajar(unaCiudad)})
	method vendedoresGenericos() = vendedores.filter({v=>v.tieneUnaCertificacionDeNoProducto()})
	method esRobusto() = vendedores.count({v=>v.esFirme()}) >= 3
	method repartirCertificacion(unaCertificacion){vendedores.forEach({v=>v.agregarCertificacion(unaCertificacion)})}
}

class Vendedor{
	const certificaciones = []
	
	method puntajeTotal() = certificaciones.sum({c=>c.creditosQueOtorga()})
	method agregarCertificacion(unaCertificacion){certificaciones.add(unaCertificacion)}
	method puedeTrabajar(unaCiudad)
	method tieneUnaCertificacionProducto() = certificaciones.any({c=>c.esDeProducto()})
	method tieneUnaCertificacionDeNoProducto() = certificaciones.any({c=> !c.esDeProducto()})
	method tieneMasDe3Certificaciones() = certificaciones.size() >= 3
	method esVersatil() = self.tieneUnaCertificacionProducto() 
						and self.tieneUnaCertificacionDeNoProducto() 
						and self.tieneMasDe3Certificaciones()
	method esFirme() = certificaciones.sum({c=>c.creditosQueOtorga()}) >= 30
	method esInfluyente()
}

class VendedorFijo inherits Vendedor{
	var property ciudadVive
	
	override method puedeTrabajar(unaCiudad) = self.ciudadVive() == unaCiudad
	override method esInfluyente() = false
}

class VendedorViajante inherits Vendedor{
	const property provincias = []
	
	method agregarProvincia(unaProvincia) {provincias.add(unaProvincia)}
	override method puedeTrabajar(unaCiudad) = provincias.contains(unaCiudad.estaEnProvincia())
	override method esInfluyente() = provincias.sum({p=>p.cantPoblacion()}) > 10000000
}

class ComercioCorresponsal inherits Vendedor{
	const property sucursales = []
	
	method agregarSucursal(unaSucursal) {sucursales.add(unaSucursal)}
	override method puedeTrabajar(unaCiudad) = sucursales.contains(unaCiudad)
	override method esInfluyente() = sucursales.size() >= 5 or sucursales.count({s=>s.estaEnProvincia()})
}


class Certificacion{
	const property esDeProducto
	const property creditosQueOtorga
	
}