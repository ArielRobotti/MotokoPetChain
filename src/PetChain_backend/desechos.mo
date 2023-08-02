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

    //Los admin podran ingresar datos relacionados con los episodios clinicos de las mascotas
    // stable var adminList = List.fromArray<Principal>([caller]);
    // func isAdmin(p : Principal) : (Bool) {
    //     let auth = List.find<Principal>(adminList, func(n) { n == caller });
    //     return switch auth {
    //         case null { false };
    //         case _ { true };
    //     };
    // };

    // public shared ({ caller }) func addAdminToList(_newAdmin : Principal) : async (Text) {

    //     if (caller != owner) { return "unauthorized caller" };
    //     if (not isAdmin(_newAdmin)) {
    //         adminList := List.push(_newAdmin, adminList); //que feo
    //         return "administrator entered successfully";
    //     };
    //     return "The administrator was already in the database";
    // };


/* 
identity owner: xyhzp-zrjop-dxido-ehezj-ipucb-todkp-5reb5-oaxey-q2nce-4ss2t-yqe
Identity motoko_bootcamp_2023: caegz-3kk7d-zfiyt-buhqv-qnbtq-f7aaj-6nbet-mms7g-5xiep-g4met-3ae

veterinaria: bkyz2-fmaaa-aaaaa-qaaaq-cai
mascota Dostoyevsky:  bw4dl-smaaa-aaaaa-qaacq-cai
---------------------------------------------
main bkyz2-fmaaa-aaaaa-qaaaq-cai

The animals Vet: ahw5u-keaaa-aaaaa-qaaha-cai
    Fiodor Pet: aax3a-h4aaa-aaaaa-qaahq-cai
Los amigos: c5kvi-uuaaa-aaaaa-qaaia-cai
    Martin Pet: c2lt4-zmaaa-aaaaa-qaaiq-cai




*/