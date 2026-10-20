class Tecnologia {
  const nombre
  const valorEnergetico
  var activa

  method nombre() = nombre

  method valorEnergetico() = valorEnergetico

  method estaActiva() = activa
}


class Equipos {
  const nombre
  const nivelDeEnergia
  const entrenador
  const tecnologiaComp

  method nombre() = nombre

  method nivelDeEnergia() = nivelDeEnergia

  method entrenador() = entrenador

  method tecnologiaComp() = tecnologiaComp

  method energiaDeTecnologias() =
    tecnologiaComp
      .filter({ tecnologia => tecnologia.estaActiva() })
      .sum({ tecnologia => tecnologia.valorEnergetico() })

  method energiaSinBonificaciones() =
    self.nivelDeEnergia() + self.energiaDeTecnologias()

  method energiaTotal() = self.energiaSinBonificaciones()
}


class LinajeLuminico inherits Equipos {
  const nivelDeRadiacion
  const nombreCristales

  method nombreCristales() = nombreCristales

  method nivelDeRadiacion() = nivelDeRadiacion

  method recibeBonificacion() =
    self.nivelDeRadiacion() <= 5000

  override method energiaTotal() {
    const energia = self.energiaSinBonificaciones()

    if (self.recibeBonificacion()) {
      return energia * 1.10
    } else {
      return energia
    }
  } 

  method esDePrestigioUniversal() =
   self.alMenos3CristalesSolares() 
   && self.entrenador().esEliteGalactico()
    && self.tecnologiaActiva()

  method alMenos3CristalesSolares() = 
  nombreCristales.size()>= 3

  method tecnologiaActiva() =
  tecnologiaComp.any({ tecnologia => tecnologia.estaActiva() })
}

class LinajeSinteticos inherits Equipos {
  const nivelDeProcesamientoCentral
  const cantidadDeModulosActivos
  const certificado

  method nivelDeProcesamientoCentral() =
    nivelDeProcesamientoCentral

  method cantidadDeModulosActivos() =
    cantidadDeModulosActivos

  method esUnidadEstableDeCompeticion() =
    certificado

  method recibePenalizacion() =
    self.cantidadDeModulosActivos() > 5

  override method energiaTotal() {
    const energia = self.energiaSinBonificaciones()

    if (self.recibePenalizacion()) {
      return energia * 0.80
    } else {
      return energia
    }
  }
  method estaCertificado() = certificado
  method esDePrestigioUniversal() = self.estaCertificado ()&&
   self.tieneMasDe3ModulosActivos() 
   && self.todasLasEnergiasActivas()

method tieneMasDe3ModulosActivos() =
  cantidadDeModulosActivos > 3
method todasLasEnergiasActivas() = 
tecnologiaComp.all({ tecnologia => tecnologia.estaActiva() })
}




class LinajeEtericos inherits Equipos {
  const nivelDeFluctuacion
  const cantidadDePortalesEnergeticos

  method nivelDeFluctuacion() =
    nivelDeFluctuacion

  method cantidadDePortalesEnergeticos() =
    cantidadDePortalesEnergeticos

  method esDePrestigioUniversal() =
    self.fluctuacionMayorA75() &&
    self.alMenos2PortalesEnergeticos() &&
    self.alMenos2TecnologiasActivas()

  method fluctuacionMayorA75() =
    nivelDeFluctuacion > 75

  method alMenos2PortalesEnergeticos() =
    cantidadDePortalesEnergeticos >= 2

  method alMenos2TecnologiasActivas() =
    self.tecnologiaComp()
      .filter({ tecnologia => tecnologia.estaActiva() })
      .size() >= 2

  override method energiaTotal() {
    const energia = self.energiaSinBonificaciones()

    if (self.esDePrestigioUniversal()) {
      return energia * 1.15
    } else {
      return energia
    }
  }
}


class Entrenador {
  const cantidadDeCiclosSolares
  var sintonia
  var nivelDePrecisionEstrategica
  const rol

  method cantidadDeCiclosSolares() = cantidadDeCiclosSolares

  method estaEnSintonia() = sintonia

  method nivelDePrecisionEstrategica() = nivelDePrecisionEstrategica

  method rol() = rol

  method tieneExperienciaSuficiente() =
    self.cantidadDeCiclosSolares() > 10

  method esEliteGalactico() =
    self.tieneExperienciaSuficiente()
     && self.cumpleSuRol()

  method cumpleSuRol() {
    if (rol == "Estratega Cuántico") {
      return nivelDePrecisionEstrategica > 80
    }

    if (rol == "Arquitecto de Energía") {
      return self.estaEnSintonia()
    }

    if (rol == "Guía Mental") {
      return true
    }

    return false
  }

  method validarRol() {
    if (
      rol != "Estratega Cuántico" &&
      rol != "Arquitecto de Energía" &&
      rol != "Guía Mental"
    ) {
      throw new Exception(message = "Rol no homologado por la FOZ")
    }
  }
}

