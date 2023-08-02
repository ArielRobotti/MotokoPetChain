import Buffer "mo:base/Buffer";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Text "mo:base/Text";


shared ({ caller }) actor class Pet(_rootPrincipal: Principal,
                                    _owner: Principal, 
                                    _name: Text,
                                    _especie : Text,
                                    _raza : Text,
                                    _fechaNacimiento : Text,
                                    _ownerName : Text,
                                    _ownerPhone : Nat,
                                    _ownerEmail : Text) {
    stable let rootPrincipal = _rootPrincipal; 
    stable let owner : Principal = _owner; // el Owner tiene exclusividad para acceder a los setters
    stable var name = _name;
    stable var especie = _especie; 
    stable var raza = _raza;
    stable var nacimiento = _fechaNacimiento;
    stable var ownerName = _ownerName;
    stable var ownerPhone = _ownerPhone;
    stable var eMail : Text = _ownerEmail;
    stable var eventosDiarios = List.nil<Text>();
    stable var eventosClinicos = List.nil<Text>();

    stable var adminArray = [caller];

    func isAdmin(p: Principal): Bool{
        for(admin in adminArray.vals()){
            if(p == admin){ return true};
        };
        return false;
    };

    public shared ({caller}) func addAdminToList(_newAdmin: Text):async Text{
        if (caller != owner) { return "unauthorized caller" };
        let newAdmin = Principal.fromText(_newAdmin);
        if (not isAdmin(newAdmin)){
            let remoteVet = actor(Principal.toText(rootPrincipal)): actor {isVet: shared (Principal) -> async Bool}; //creo una referencia al supuesto canister Vet
            let acceptPrincipal = await remoteVet.isVet(newAdmin);
            if(not acceptPrincipal){return "The Principal is not Vet"};//Comprobamos que el Principal ingresado es de un Vet
            var tempBuffer = Buffer.fromArray<Principal>(adminArray);
            tempBuffer.add(newAdmin);
            adminArray := Buffer.toArray(tempBuffer);
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
    public shared query ({ caller }) func getOwner(): async Text {
        if (isAdmin(caller) or caller == owner) { return Principal.toText(owner)};
        return "";
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
