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

    stable var admins : [Principal] = [caller, _owner];

    public shared ({ caller }) func addAdmin(_newAdmin : Principal) : async (Text) {

        for (i in Iter.range(0, Array.size(admins) - 1)) {
            if (admins[i] == _newAdmin) {
                return "The administrator was already in the database";
            };
            if (admins[i] == caller) {
                for (j in Iter.range(i + 1, Array.size(admins) - 1)) {
                    if (admins[j] == _newAdmin) {
                        return "The administrator was already in the database";
                    };
                };
                admins := Array.append(admins,[_newAdmin]);
                return "administrator entered successfully";
            };
        };
        return "unauthorized caller";
    };

    public shared ({caller}) func addAdminToList(_newAdmin: Principal):async (Text){
        let auth: ?Principal = List.find<Principal>(adminList, func(n) {n == caller});
        switch auth{
            case null{return "unauthorized caller"};
            case _{};
        };
        let inList: ?Principal = List.find<Principal>(adminList, func(n) {n == _newAdmin});
        switch inList{
            case null{
                adminList:= List.push(_newAdmin, adminList);
                //List.push<Principal>(_newAdmin, adminList);
                return "administrator entered successfully";
            };
            case _{return "The administrator was already in the database";};
        };


        return "end";
    };
    public shared ({ caller }) func getName() : async Text {
        "E"
    }

};
