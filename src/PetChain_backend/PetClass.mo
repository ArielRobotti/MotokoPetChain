import Buffer "mo:base/Buffer";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";

shared ({ caller }) actor class Pet(_owner: Principal, _name: Text) {
    stable var name = _name;
    stable let owner: Principal = _owner;
    stable var ownerFullName = "";
    stable var ownerPhone = 0;
    stable var eMail : Text = "";
    stable var adminList = List.fromArray<Principal>([caller]);


    func isAdmin(p : Principal) : (Bool) {
        let auth = List.find<Principal>(adminList, func(n) { n == caller });
        return switch auth {
            case null { false };
            case _ { true };
        };
    };

    public shared ({ caller }) func addAdminToList(_newAdmin : Principal) : async (Text) {

        if (not isAdmin(caller) and caller != owner) { return "unauthorized caller" };
        if (not isAdmin(_newAdmin)) {
            adminList := List.push(_newAdmin, adminList); //que feo
            return "administrator entered successfully";
        };
        return "The administrator was already in the database";
    };

    public shared query ({ caller }) func getInfo() : async [Text] {
        if (isAdmin(caller) or caller == owner) {
            return ["Nombre: " # name,
                    "Amo: " # ownerFullName,
                    "Phone: " # Nat.toText(ownerPhone),
                    "Email: " # eMail];
        };
        return [];
    };
    public shared({caller}) func setName(_newName: Text):async Text{
        if(caller == owner){
            if (_newName != "" ){
                name := _newName;
                return "El nuevo nombre es: " # name; 
            }
            else{
                 return "El nombre no puede estar vacío";
            }      
        };
        return "El nombre no fue modificado";
    };
    public shared({caller}) func setOwnerFullName(_newName: Text):async Text{
        if(caller == owner){
            if(_newName != "" ){
                ownerFullName := _newName;
                return "Nombre del dueño actualizado a: " # name; 
            }
            else{
                return "El nombre no puede estar vacío";
            };       
        };
        return "Acceso denegado";
    };
    public shared({caller}) func setOwnerPhone(_newPhone: Nat):async Text{
        if(caller == owner){
            if(_newPhone > 100000 ){
                ownerPhone := _newPhone;
                return "Telefono de contacto actualizado"; 
            }
            else{
                return "El numero no es valido";
            };       
        };
        return "Acceso denegado";
    };
    public shared({caller}) func setEmail(_newEmail: Text):async Text{
        if(caller == owner){
            if(_newEmail != ""){
                eMail := _newEmail;
                return "Email actualizado"; 
            }
            else{
                return "El formato no es valido";
            };       
        };
        return "Acceso denegado";
    };

};
