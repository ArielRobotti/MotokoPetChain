import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Cycles "mo:base/ExperimentalCycles";
import List "mo:base/List";
import Types "Types";
import Time "mo:base/Time";
import Array "mo:base/Array";
import PetClass "PetClass";

shared ({ caller }) actor class Vet(_owner : Principal, data : Types.initVetData) {
    stable let rootPrincipal = caller; //corresponde al Principal del main
    stable let owner = _owner; //este Principal es el caller que envía el form desde el main
    stable var nombre = data.nombre;
    stable var titular = data.titular;
    stable var domicilio = data.domicilio;
    stable var telefono = data.telefono;
    stable var eMail = data.eMail;
    stable var matricula = data.matricula;

    stable var petArray : [Principal] = [];

    //---- declaraciones de tipos -----
    type Turno = Types.Turno;
    type Clinical_record = Types.Clinical_record;
    type Evento = Types.Evento;

    //stable var calendarioTurnos: [[Turno]] = [];

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
    public shared ({ caller }) func setTelefono(_t : Text) : async Bool {
        if (caller == owner and _t != "") {
            domicilio := _t;
            return true;
        };
        return false;
    };

    //----------------------- getters ------------------------------------------------
    public shared query func getInfo() : async [Text] {
        [
            "Nombre veterinaria: " # nombre,
            "Domicilio: " # domicilio,
            "Telefono: " # telefono,
            "email: " # eMail,
            "Principal ID: " # Principal.toText(owner),
            "Titular: " # titular,
        ];
    };
    public query func getMiPets() : async [Principal] { petArray };
    public query func getOwner() : async Text { Principal.toText(owner) };
    public query func getTitular() : async Text { titular };
    public query func getNombre() : async Text { nombre };
    public query func getDomicilio() : async Text { domicilio };
    public query func getMail() : async Text { eMail };
    public query func getTelefono() : async Text { telefono };

    public shared ({ caller }) func getInfoFromPet(petPrincipal : Text) : async [Text] {
        if (caller != owner) { return [] };
        let remotePet = actor (petPrincipal) : actor { getInfo : shared () -> async [Text]; }; // referencia a canister Pet
        await remotePet.getInfo();
    };

    // --------------------- Para el calendario ----------------------------------------------------------
    /* public query func dayFromTimeStamp(t : Int) : async Text {
        let daysOfWeek = ["lunes", "martes", "miercoles", "jueves", "viernes", "", ""];
        let index = (t / 86400 + 3) % 7;
        daysOfWeek[Int.abs(index)];
    };
    */

    public shared ({ caller }) func writeRegOnPet(pet : Text, rec : Clinical_record) : async Bool {
        if (caller != owner) { return false };
        let remotePet = actor (pet) : actor {
            writeClinicReg : shared (Clinical_record) -> async Bool;
        };
        let success = await remotePet.writeClinicReg(rec);
        success;
    };

    public shared ({ caller }) func getClinicHistory(pet : Text) : async [Clinical_record] {
        if (caller != owner) { return [] };
        let remotePet = actor (pet) : actor {
            readClinicReg : shared () -> async [Clinical_record];
        };
        await remotePet.readClinicReg();
    };

    public shared ({ caller }) func readEventosDiariosOnPet(pet : Text) : async [Evento] {
        if (caller != owner) { return [] };
        let remotePet = actor (pet) : actor {
            readEventosDiarios : shared () -> async [Evento];
        };
        await remotePet.readEventosDiarios();
    };
};
