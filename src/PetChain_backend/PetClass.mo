import Buffer "mo:base/Buffer";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Types "Types";

shared ({ caller }) actor class Pet(_owner : Principal, data : Types.initPetData) {
    stable let rootPrincipal = caller; // Este principal es para interactuar con el canister main
    stable let owner : Principal = _owner; // el Owner tiene exclusividad para acceder a los setters
    stable var name = data.name;
    stable var especie = data.especie;
    stable var raza = data.raza;
    stable var nacimiento = data.nacimiento;
    stable var ownerName = data.ownerName;
    stable var ownerPhone = data.ownerPhone;
    stable var eMail : Text = data.eMail;

    stable var eventosDiarios : [Evento] = [];
    stable var eventosClinicos : [Clinical_record] = []; //

    stable var adminArray = [caller]; //El unico admin hasta aquí es el Vet desde el que se creó  este Pet

    //---------- declaraciones de tipos -------
    type Clinical_record = Types.Clinical_record;
    type Evento = Types.Evento;
    type initPetData = Types.initPetData;
    //-------------------------------------------
    
    func isAdmin(p : Principal) : Bool {
        for (admin in adminArray.vals()) { if (p == admin) { return true } };
        return false;
    };

    public shared ({ caller }) func addAdminToArray(_newAdmin : Text) : async Text {
        if (caller != owner) { return "unauthorized caller" };
        let newAdmin = Principal.fromText(_newAdmin);
        if (isAdmin(newAdmin)) {
            return "The administrator was already in the database";
        };

        let remoteRoot = actor (Principal.toText(rootPrincipal)) : actor {
            isVet : shared (Principal) -> async Bool;
        }; //referencia al canister main
        let acceptPrincipal = await remoteRoot.isVet(newAdmin); //Verificamos que el principal ingresado es un Vet (funcion isVet del canister main)
        if (not acceptPrincipal) { return "The Principal is not Vet" };

        var tempBuffer = Buffer.fromArray<Principal>(adminArray);
        tempBuffer.add(newAdmin);
        adminArray := Buffer.toArray(tempBuffer);
        return "administrator entered successfully";
    };

    // -------------- Getters. Acceso permitido al owner y admins de este Pet ----------------------
    public shared query ({ caller }) func getInfo() : async [Text] {
        if (isAdmin(caller) or caller == owner) {
            return [
                "Nombre: " # name,
                "Cliente: " # ownerName,
                "Phone: " # ownerPhone,
                "Email: " # eMail,
            ];
        };
        return ["Acceso no permitido"];
    };
    public shared query ({ caller }) func getOwner() : async Text {
        if (isAdmin(caller) or caller == owner) {
            return Principal.toText(owner);
        };
        return "Acceso no permitido";
    };
    public shared query ({ caller }) func getName() : async Text {
        if (isAdmin(caller) or caller == owner) { return name };
        return "Acceso no permitido";
    };
    public shared query ({ caller }) func getOwnerName() : async Text {
        if (isAdmin(caller) or caller == owner) { return ownerName };
        return "Acceso no permitido";
    };
    public shared query ({ caller }) func getOwnerPhone() : async Text {
        if (isAdmin(caller) or caller == owner) { return ownerPhone };
        return "Acceso no permitido";
    };
    public shared query ({ caller }) func getEmail() : async Text {
        if (isAdmin(caller) or caller == owner) { return eMail };
        return "Acceso no permitido";
    };

    //---------- Accesibles solo desde canisters Vet que son Admins de este canister Pet -------------

    public shared ({ caller }) func writeClinicReg(rec : Clinical_record) : async Bool {
        if (not isAdmin(caller)) { return false };
        var tempBuffer = Buffer.fromArray<Clinical_record>(eventosClinicos);
        tempBuffer.add(rec);
        eventosClinicos := Buffer.toArray(tempBuffer);
        return true;
    };

    public shared ({ caller }) func readClinicReg() : async [Clinical_record] {
        if (not isAdmin(caller) and caller != owner) { return [] };
        return eventosClinicos;
    };

    // --------- Setters. Acceso permitido solo al owner ----------
    public shared ({ caller }) func setName(_newName : Text) : async Bool {
        if (caller == owner and _newName != "") {
            name := _newName;
            return true;
        };
        return false;
    };
    public shared ({ caller }) func setOwnerName(_newName : Text) : async Bool {
        if (caller == owner and _newName != "") {
            ownerName := _newName;
            return true;
        };
        return false;
    };
    public shared ({ caller }) func setOwnerPhone(_newPhone : Text) : async Bool {
        if (caller == owner and Text.size(_newPhone) > 5) {
            ownerPhone := _newPhone;
            return true;
        };
        return false;
    };
    public shared ({ caller }) func setEmail(_newEmail : Text) : async Bool {
        if (caller == owner and Text.contains(_newEmail, #char '@')) {
            eMail := _newEmail;
            return true;
        };
        return false;
    };
    //------ Registro de eventos cotidianos. Acceso permitido solo al owner ------------------
    public shared ({ caller }) func writeOnEventosDiarios(ev : Evento) : async Bool {
        if (caller != owner) { return false };
        var tempBuffer = Buffer.fromArray<Evento>(eventosDiarios);
        tempBuffer.add(ev);
        eventosDiarios := Buffer.toArray<Evento>(tempBuffer);
        return true;
    };
    public shared ({ caller }) func readEventosDiarios() : async [Evento] {
        if (caller != owner and not isAdmin(caller)) { return [] };
        return eventosDiarios;
    };

};
