
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Cycles "mo:base/ExperimentalCycles";
import List "mo:base/List";
import Types "Types";
import Time "mo:base/Time";
import Int "mo:base/Int";
import Array "mo:base/Array";
import PetClass "PetClass";

shared ({ caller }) actor class Vet(_owner : Principal,
                                    _nombre : Text,
                                    _titular : Text,
                                    _domicilio : Text) {
    stable let rootPrincipal = caller; //corresponde al Principal del main
    stable let owner = _owner;
    stable var nombre = _nombre;
    stable var titular = _titular;
    stable var domicilio = _domicilio;
    
    stable var petList = List.nil<Principal>(); //Cambiar por un Array

    //---- declaraciones de tipos -----
    type Turno = Types.Turno;
    
    //stable var calendarioTurnos: [[Turno]] = [];

    public shared ({ caller }) func newPet(_name : Text) : async Principal {
        //FEE 13846199230
        Cycles.add(13846199230);
        let miPet = await PetClass.Pet(rootPrincipal, caller, _name, "", "", "", "", 0, ""); // se instancia un actor de tipo Pet
        let principal = Principal.fromActor(miPet); // se guarda el Principal del canister creado
        petList := List.push(principal, petList); // en la lista de Pets
        return principal; // y se retorna el principal para poder acceder luego al canister
    };

    //----------------------------- setters ----------------------------------------
    public shared ({ caller }) func setTitular(_titular : Text) : async Bool {
        if (caller == owner and _titular != "") {
            titular := _titular;
            return true;
        };
        return false;
    };
    public shared ({ caller }) func setNombre(_nombre : Text) : async Bool {
        if (caller == owner and _nombre != "") {
            nombre := _nombre;
            return true;
        };
        return false;
    };
    public shared ({ caller }) func setDomicilio(_domicilio : Text) : async Bool {
        if (caller == owner and _domicilio != "") {
            domicilio := _domicilio;
            return true;
        };
        return false;
    };

    //----------------------- getters ------------------------------------------------
    public shared query func getInfo(): async [Text]{
        ["Nombre veterinaria: " # nombre, 
        "Domicilio: " # domicilio,
        "Principal ID: " # Principal.toText(owner),
        "Titular: " # titular];
    };
    public query func getMiPets() : async [Principal] { List.toArray<Principal>(petList)};
    public query func getOwner() : async Text { Principal.toText(owner) };
    public query func getTitular() : async Text { titular };
    public query func getNombre() : async Text { nombre };
    public query func getDomicilio() : async Text { domicilio };
   
    public shared ({ caller }) func getInfoFromPet(petPrincipal : Text) : async [Text] {
        if (caller != owner) { return [] };
        let remotePet = actor (petPrincipal): actor {getInfo: shared () -> async [Text]}; // referencia a canister Pet
        await remotePet.getInfo();
    };

    // -------------------------------------------------------------------------------
    public query func dayFromTimeStamp(t : Int) : async Text {
        let daysOfWeek = ["lunes", "martes", "miercoles", "jueves", "viernes", "", ""];
        let index = (t / 86400 + 3) % 7;
        daysOfWeek[Int.abs(index)];
    };

};
