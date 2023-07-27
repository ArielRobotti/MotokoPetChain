import Iter "mo:base/Iter";
import Array "mo:base/Array";

actor {
    stable var admins : [Principal] = [];
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
                admins := Array.append(admins, [_newAdmin]);
                return "administrator entered successfully";
            };
        };
        return "unauthorized caller";
    };
};
