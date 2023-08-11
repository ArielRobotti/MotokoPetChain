import { PetChain_backend } from "../../declarations/PetChain_backend";
console.log("cargando");
document.querySelector("form").addEventListener("submit", async (e) => {

    e.preventDefault();
    const button = e.target.querySelector("button");
  
    const nomVet = document.getElementById("nombreVeterinaria").value.toString();
    const direccion = document.getElementById("direccion").value.toString();
    const telefono = document.getElementById("telefono").value.toString();
    const eMail = document.getElementById("eMail").value.toString();
    const titular = document.getElementById("titular").value.toString();
    const matricula = document.getElementById("matricula").value.toString();
   
  
    button.setAttribute("disabled", true);
  
    // Interact with foo actor, calling the greet method
    //const greeting = await PetChain_backend.greet(name);
  
    button.removeAttribute("disabled");
  
    //document.getElementById("greeting").innerText = greeting;
    console.log("Enviando form");
    return false;
  });