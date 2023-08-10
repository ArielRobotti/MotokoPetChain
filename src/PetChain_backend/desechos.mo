import Iter "mo:base/Iter";
import Array "mo:base/Array";

actor {
    
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
identity mqtt: xyhzp-zrjop-dxido-ehezj-ipucb-todkp-5reb5-oaxey-q2nce-4ss2t-yqe
Identity motoko_bootcamp_2023: caegz-3kk7d-zfiyt-buhqv-qnbtq-f7aaj-6nbet-mms7g-5xiep-g4met-3ae

---------------------------------------------
root bkyz2-fmaaa-aaaaa-qaaaq-cai
    Vet Hola Mundo Animal: asrmz-lmaaa-aaaaa-qaaeq-cai
        pet Alma:   br5f7-7uaaa-aaaaa-qaaca-cai
        pet Blacky: bw4dl-smaaa-aaaaa-qaacq-cai
        pet Tobby:  by6od-j4aaa-aaaaa-qaadq-cai
    Vet Animalix: avqkn-guaaa-aaaaa-qaaea-cai
------------------------------------------------







main: bkyz2-fmaaa-aaaaa-qaaaq-cai
    Vet Hola Mundo Animal: aax3a-h4aaa-aaaaa-qaahq-cai
        Pet Alma: c5kvi-uuaaa-aaaaa-qaaia-cai
    Vet Animalix: c2lt4-zmaaa-aaaaa-qaaiq-cai
    
























main: bkyz2-fmaaa-aaaaa-qaaaq-cai
Los amigos: be2us-64aaa-aaaaa-qaabq-cai no tiene getInfo
    Tobby: br5f7-7uaaa-aaaaa-qaaca-cai
The animals: bw4dl-smaaa-aaaaa-qaacq-cai no tiene getInfo
TAREA: ver como actualizar un canister generado desde otro canister

Animalix: b77ix-eeaaa-aaaaa-qaada-cai
    Roky: by6od-j4aaa-aaaaa-qaadq-cai

dfx canister call br5f7-7uaaa-aaaaa-qaaca-cai addAdminToList '("bw4dl-smaaa-aaaaa-qaacq-cai")'



*/