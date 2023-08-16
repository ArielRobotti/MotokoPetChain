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
    if (event.target.id === "crearMascota") {
      cargarContenidoDinamico("crear-mascota.html");
      vista = event.target.id;
    } else if (event.target.id === "crearVeterinaria") {
      cargarContenidoDinamico("crear-veterinaria.html");
      vista = event.target.id;
    } else if (event.target.id === "newPet") {
      event.preventDefault();
      console.log("PetChain_backend.newPet()");
    } else if (event.target.id === "newVet") {
      event.preventDefault();
      const vetForm = document.getElementById("vet-form");
      const formData = new FormData(vetForm);
      console.log(formData.get("nombreVeterinaria"));
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
  }
});



