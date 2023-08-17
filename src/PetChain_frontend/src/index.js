import { PetChain_backend } from "../../declarations/PetChain_backend";

document.addEventListener("DOMContentLoaded", function () {

  var contenidoDinamico = document.getElementById("contenido-dinamico");
  var nav = document.getElementsByTagName("nav")[0];
  cargarContenidoDinamico("crear-perfil.html")
  var vista = "inicio";

  nav.addEventListener("click", function(event){
    event.preventDefault();
    console.log(event.target.id);
    if(vista === event.target.id){return};
    vista = event.target.id;
    if(event.target.id === "inicio"){cargarContenidoDinamico("crear-perfil.html")}
    else if(event.target.id === "about"){cargarContenidoDinamico("about.html")}
    else if(event.target.id === "tutorial"){}
    else if(event.target.id === "ICP"){window.location.href = "https://internetcomputer.org/"}
    else if(event.target.id === "ask"){};    
  })

  contenidoDinamico.addEventListener("click", async function (event) {
    console.log(event.target.id);
    if (event.target.id === "crearMascota") {
      cargarContenidoDinamico("crear-mascota.html");
      vista = event.target.id;
    } 
    else if (event.target.id === "crearVeterinaria") {
      cargarContenidoDinamico("crear-veterinaria.html");
      vista = event.target.id;
    } 
    else if (event.target.id === "newPet") { //enviar los datos del form al contructor de Pet
      event.preventDefault();    
      const petForm = document.getElementById("pet-form");
      if(!formOK(petForm)){ return };
      console.log("sigamos");
      
      const formData = new FormData(petForm);
      const args = {name: formData.get("nombreMascota"),
                    nacimiento: formData.get("fechaNacimiento"),
                    especie: formData.get("especie"),
                    raza: formData.get("raza"),
                    ownerName: formData.get("nombreClient"),
                    ownerPhone: formData.get("telefono"),
                    eMail : formData.get("email"),
                  };
      const principalPet = await PetChain_backend.newPet(args);
      console.log(principalPet);
    } 
    else if (event.target.id === "newVet") { //enviar los datos del form al contructor de Vet
      event.preventDefault();
      const vetForm = document.getElementById("vet-form");
      const formData = new FormData(vetForm);
      const principalVet = await PetChain_backend.newVet(formData.get("nombreVeterinaria"),
                                                    formData.get("direccion"),
                                                    formData.get("telefono"),
                                                    formData.get("eMail"),
                                                    formData.get("titular"),
                                                    formData.get("matricula"),
                                                    );
      console.log(principalVet);
      
    };
  });

  function cargarContenidoDinamico(url) {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", url, true);
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4 && xhr.status === 200) {
        contenidoDinamico.innerHTML = xhr.responseText;
        var contNuevo = contenidoDinamico.firstElementChild;
        contNuevo.style.opacity = "0"; // Configurar el nuevo contenido con opacidad 0

        setTimeout(function () {
          contNuevo.style.opacity = "1"; // Aplicar fade in al nuevo contenido
        }, 10);
      }
    };
    xhr.send();
  };

  function formOK(form){
    console.log("verificando form...");
    const campos = form.querySelectorAll("input[required]");
    for(const campo of campos) { 
      if (!campo.value) {
        console.log("Campo incompleto");
        campo.classList.add("campo-incompleto");
        return false
      }else {
        campo.classList.remove("campo-incompleto");
      };
    }
    console.log("campos completos");
    return true;
  };

});



