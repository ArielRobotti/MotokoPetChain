import Buffer "mo:base/Buffer";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Types "Types";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";



shared ({ caller }) actor class Pet(

    _owner : Principal,
    _name : Text,
    _especie : Text,
    _raza : Text,
    _fechaNacimiento : Text,
    _ownerName : Text,
    _ownerPhone : Nat,
    _ownerEmail : Text,
) {
    type Turno = Types.Turno;
    stable let owner : Principal = _owner; // el Owner tiene exclusividad para acceder a los setters
    stable var name = _name;
    stable var especie = _especie; //estos campos suelen no ser variables pero pueden ser cargados con errores
    stable var raza = _raza;
    stable var naciminento = _fechaNacimiento;
    stable var ownerName = _ownerName;
    stable var ownerPhone = _ownerPhone;
    stable var eMail : Text = _ownerEmail;
    stable var eventosDiarios = List.nil<Text>();
    stable var eventosClinicos = List.nil<Text>();

    //Los admin podran ingresar datos relacionados con los episodios clinicos de las mascotas
/*  stable var adminList = List.fromArray<Principal>([caller]);

    func isAdmin(p : Principal) : (Bool) {
        let auth = List.find<Principal>(adminList, func(n) { n == caller });
        return switch auth {
            case null { false };
            case _ { true };
        };
    };
*/
    stable var adminList: [Principal] = [caller];

    func isAdmin(p: Principal): Bool{
        for(admin in adminList.vals()){
            if(p == admin){
                return true;
            };     
        };
        return false;
    };

    public shared ({ caller }) func consultarTurnos(/*admin 0 por defecto*/) : async [Turno]{
        if(caller != owner and not isAdmin(caller)){return []}; //envolver en Result

        let remoteVet = actor (Principal.toText(adminList[0])) : actor {
            turnosDisponibles : shared () -> async [Turno];
        };
        return await remoteVet.turnosDisponibles();
    };

    public shared ({ caller }) func addAdminToList(_newAdmin : Principal) : async Text {

        if (caller != owner) { return "unauthorized caller" };
        if (not isAdmin(_newAdmin)) {
            var tempBuf = Buffer.fromArray<Principal>(adminList);
            tempBuf.add(_newAdmin);
            adminList := Buffer.toArray(tempBuf);
            return "administrator entered successfully";
        };
        return "The administrator was already in the database";
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
    public shared ({ caller }) func setOwnerPhone(_newPhone : Nat) : async Bool {
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

    // ------ Getters -------
    public shared query ({ caller }) func getInfo() : async [Text] {
        if (isAdmin(caller) or caller == owner) {
            return [
                "Nombre: " # name,
                "Cliente: " # ownerName,
                "Phone: " # Nat.toText(ownerPhone),
                "Email: " # eMail,
            ];
        };
        return [];
    };
    public shared query ({ caller }) func getName(): async Text {
        if (isAdmin(caller) or caller == owner) { return name };
        return "";
    };
    public shared query ({ caller }) func getOwnerName(): async Text {
        if (isAdmin(caller) or caller == owner) { return ownerName };
        return "";
    };
    public shared query ({ caller }) func getOwnerPhone(): async Nat {
        if (isAdmin(caller) or caller == owner) {return ownerPhone };
        return 0;
    };
    public shared query ({ caller }) func getEmail(): async Text {
        if (isAdmin(caller) or caller == owner) {return eMail};
        return "";
    };

};
