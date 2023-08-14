import { PetChain_backend } from "../../declarations/PetChain_backend";

document.addEventListener("DOMContentLoaded", function () {
  var contenidoDinamico = document.getElementById("contenido-dinamico");
  var botonInicio = document.getElementById("inicio");
  cargarContenidoDinamico("crear-perfil.html")

  botonInicio.addEventListener("click", function () {
    cargarContenidoDinamico("crear-perfil.html");
  });
  contenidoDinamico.addEventListener("click", function (event) {
    console.log(event.target.id);
    if (event.target.id === "crearMascota") {
      cargarContenidoDinamico("crear-mascota.html");
    } else if (event.target.id === "crearVeterinaria") {
      cargarContenidoDinamico("crear-veterinaria.html");
    }
  });

  function cargarContenidoDinamico(url) {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", url, true);
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4 && xhr.status === 200) {
        contenidoDinamico.innerHTML = xhr.responseText;
      }
    };
    xhr.send();
  }
  var vets = PetChain_backend.isVet("ytdlf-kaaaa-aaaak-qcjwq-cai");
  console.log(vets);
});
