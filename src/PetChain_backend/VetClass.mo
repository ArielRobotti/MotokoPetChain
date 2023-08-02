import PetClass "PetClass";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Cycles "mo:base/ExperimentalCycles";
import List "mo:base/List"

shared ({ caller }) actor class Vet(
    _owner : Principal,
    _titular : Text,
    _nombre : Text,
    _domicilio : Text,
) {
    stable let rootPrincipal = caller;
    stable let owner = _owner;
    stable var titular = _titular;
    stable var nombre = _nombre;
    stable var domicilio = _domicilio;

    stable var petList = List.nil<Principal>(); //Cambiar por un Array

    public shared ({ caller }) func newPet(_name : Text) : async Principal {
        //FEE 13846199230
        Cycles.add(13846199230);
        let miPet = await PetClass.Pet(rootPrincipal, caller, _name, "", "", "", "", 0, ""); // se instancia un actor de tipo Pet
        let principal = Principal.fromActor(miPet); // se guarda el Principal del canister creado
        petList := List.push(principal, petList); // en la lista de Pets
        return principal; // y se retorna el principal para poder acceder luego al canister
    };

    // ----------------------------------------------------------------------------------
    // Provisorio... se planea convertir este actor en un actor class instanciable desde un canister superior en el que
    // habra una lista de veterinarios acreditados, mediante la que se podrá confirmar si un Principal corresponde a un Vet
    public shared func isVet() : async Bool { true };
    // ----------------------------------------------------------------------------------

    public query func getMiPets() : async [Principal] {
        List.toArray<Principal>(petList);
    };
};
