import Buffer "mo:base/Buffer";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Nat16 "mo:base/Nat16";
import Iter "mo:base/Iter";
import List "mo:base/List";

shared ({ caller }) actor class Pet(_owner : Principal, _name : Text, _ownerFullName : Text, _ownerPhone : Nat64) {
    stable let name = _name;
    stable let owner = _owner;
    stable var ownerFullName = _ownerFullName;
    stable var ownerPhone = _ownerPhone;
    stable var eMail : Text = "";
    stable var adminList = List.nil<Principal>();

    func isAdmin(p : Principal) : (Bool) {
        let auth = List.find<Principal>(adminList, func(n) { n == caller });
        return switch auth {
            case null { false };
            case _ { true };
        };
    };

    public shared ({ caller }) func addAdminToList(_newAdmin : Principal) : async (Text) {

        if (not isAdmin(caller)) { return "unauthorized caller" };
        if (not isAdmin(_newAdmin)) {
            adminList := List.push(_newAdmin, adminList); //que feo
            return "administrator entered successfully";
        };
        return "The administrator was already in the database";
    };

    public shared query ({ caller }) func getName() : async Text {
        if (isAdmin(caller)) {
            return name;
        };
        return "";
    };

};
