import Buffer "mo:base/Buffer";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Types "Types";

shared ({ caller }) actor class Pet(
    _root : Principal,
    _owner : Principal,
    _name : Text,
    _especie : Text,
    _raza : Text,
    _fechaNacimiento : Text,
    _ownerName : Text,
    _ownerPhone : Int,
    _ownerEmail : Text,
    ) {

    //---------- declaraciones de typos -------
    type Clinical_record = Types.Clinical_record;
    type Evento = Types.Evento;

    // ----------------------------------------------
    stable let root = _root; // Este principal es para interactuar con el canister main
    stable let owner : Principal = _owner; // el Owner tiene exclusividad para acceder a los setters
    stable var name = _name;
    stable var especie = _especie;
    stable var raza = _raza;
    stable var nacimiento = _fechaNacimiento;
    stable var ownerName = _ownerName;
    stable var ownerPhone = _ownerPhone;
    stable var eMail : Text = _ownerEmail;
    stable var eventosDiarios : [Evento] = [];
    stable var eventosClinicos : [Clinical_record] = []; //

    stable var adminArray = [caller]; //El unico admin hasta aquí es el Vet desde el que se creó  este Pet

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

        let remoteRoot = actor (Principal.toText(root)) : actor {
            isVet : shared (Principal) -> async Bool;
        }; //referencia al canister main
        let acceptPrincipal = await remoteRoot.isVet(newAdmin); // Verificamos que el principal ingresado es un Vet (funcion isVet del canister main)
        if (not acceptPrincipal) { return "The Principal is not Vet" };

        var tempBuffer = Buffer.fromArray<Principal>(adminArray);
        tempBuffer.add(newAdmin);
        adminArray := Buffer.toArray(tempBuffer);
        return "administrator entered successfully";
    };

    // ------ Setters -------
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
    public shared ({ caller }) func setOwnerPhone(_newPhone : Int) : async Bool {
        if (caller == owner and _newPhone > 100000) {
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

    // ------------------------ Getters -----------------------------
    public shared query ({ caller }) func getInfo() : async [Text] {
        if (isAdmin(caller) or caller == owner) {
            return [
                "Nombre: " # name,
                "Cliente: " # ownerName,
                "Phone: " # Int.toText(ownerPhone),
                "Email: " # eMail,
            ];
        };
        return [];
    };
    public shared query ({ caller }) func getOwner() : async Text {
        if (isAdmin(caller) or caller == owner) {
            return Principal.toText(owner);
        };
        return "";
    };
    public shared query ({ caller }) func getName() : async Text {
        if (isAdmin(caller) or caller == owner) { return name };
        return "";
    };
    public shared query ({ caller }) func getOwnerName() : async Text {
        if (isAdmin(caller) or caller == owner) { return ownerName };
        return "";
    };
    public shared query ({ caller }) func getOwnerPhone() : async Int {
        if (isAdmin(caller) or caller == owner) { return ownerPhone };
        return 0;
    };
    public shared query ({ caller }) func getEmail() : async Text {
        if (isAdmin(caller) or caller == owner) { return eMail };
        return "";
    };

    //--------------------------------------------------------
    public shared ({ caller }) func writeClinicReg2(
        _date : Int,
        _sintomas : Text,
        _diagnostico : Text,
        _tratamiento : Text,
        ) : async Bool {
        if (not isAdmin(caller)) { return false };
        var tempBuffer = Buffer.fromArray<Clinical_record>(eventosClinicos);
        let registro: Clinical_record = {
            date = _date;
            sintomas = _sintomas;
            diagnostico = _diagnostico;
            tratamiento = _tratamiento;
        };
        tempBuffer.add(registro);
        eventosClinicos := Buffer.toArray<Clinical_record>(tempBuffer);
        return true;
    };
    public shared ({caller}) func writeClinicReg(rec: Clinical_record): async Bool{
        if (not isAdmin(caller)) { return false };
        var tempBuffer = Buffer.fromArray<Clinical_record>(eventosClinicos);
        tempBuffer.add(rec);
        eventosClinicos := Buffer.toArray(tempBuffer);
        return true;
    };

    public shared ({caller}) func readClinicReg(): async [Clinical_record]{
        if (not isAdmin(caller) and caller != owner) { return [] };
        return eventosClinicos;
    };

    public shared ({caller}) func writeOnEventosDiarios(ev: Evento): async Bool{
        if(caller != owner){return false};
        var tempBuffer = Buffer.fromArray<Evento>(eventosDiarios);
        tempBuffer.add(ev);     //ev vendrá con el formato adecuado desde el frontend 
        eventosDiarios := Buffer.toArray<Evento>(tempBuffer);
        return true;
    };
    public shared ({caller}) func readEventosDiarios(): async [Evento]{
        if(caller != owner and not isAdmin(caller)){ return []};
        return eventosDiarios;
    };

};
