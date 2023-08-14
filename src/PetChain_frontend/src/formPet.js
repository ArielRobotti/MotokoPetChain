//import { PetChain_backend } from "../../declarations/PetChain_backend";

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();

  const nombrePet = document.getElementById("nombreMascota").value.toString();
  const fechaNacimiento = document.getElementById("fechaNacimiento").value.toString();
  const especie = document.getElementById("especie").value.toString();
  const raza = document.getElementById("raza").value.toString();
  const nombreClient = document.getElementById("nombreClient").value.toString();
  const tel = document.getElementById("telefono").value.toString();
  const email = document.getElementById("email").value.toString();

  console.log(nombrePet, email);
});