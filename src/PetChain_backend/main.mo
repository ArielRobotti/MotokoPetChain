/*
PetChain_backend canister created on network ic with canister  id: yucnr-hyaaa-aaaak-qcjwa-cai, 
    Local: bkyz2-fmaaa-aaaaa-qaaaq-cai (Identity Motoko_bootcamp2023)
    http://127.0.0.1:4943/?canisterId=bw4dl-smaaa-aaaaa-qaacq-cai&id=bd3sg-teaaa-aaaaa-qaaba-cai
PetChain_frontend canister created on network ic with canister id: ytdlf-kaaaa-aaaak-qcjwq-cai, 
    Local: bd3sg-teaaa-aaaaa-qaaba-cai (Identity Motoko_bootcamp2023)
    PetChain_frontend: http://127.0.0.1:4943/?canisterId=br5f7-7uaaa-aaaaa-qaaca-cai

Mainet front canister: https://ytdlf-kaaaa-aaaak-qcjwq-cai.icp0.io/

Mainet back  canister: https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.icp0.io/?id=yucnr-hyaaa-aaaak-qcjwa-cai

*/
import VetClass "VetClass";
import PetClass "PetClass";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Cycles "mo:base/ExperimentalCycles";
import HashMap "mo:base/HashMap";
import Types "Types";

shared ({caller}) actor class Root(){
  stable var vetArray : [Principal] = [];   //array de canister Vet creados
  stable var petArray : [Principal] = [];   //array de canister Pet creados
  var controller = caller;

  public shared ({caller}) func resetVetArray(){
    if(caller == controller) { vetArray := []}
  };
  public shared ({caller}) func resetPetArray(){
    if(caller == controller) { petArray := []}
  };

  //------------------------------- declaraciones de tipos ----------------------------------
  type initVetData = Types.initVetData;     //Type con los campos para crear un canister Vet
  type initPetData = Types.initPetData;     //Type con los campos para crear un canister Vet
  type petInfo = Types.petInfo;             
  type vetInfo = Types.vetInfo;


  //--------------------- Funcion para crear un canister de tipo Vet ------------------------
  public shared ({ caller }) func newVet(initData: initVetData) : async Text {
    if(Principal.isAnonymous(caller)){return "Identifíquese"};
    Cycles.add(113_846_199_230);         //FEE para crear un canister 13 846 199 230
    let miVet = await VetClass.Vet(caller, initData);   // se crea un actor de tipo Vet
    let principal = Principal.fromActor(miVet);         // se guarda el Principal del canister creado
    var tempBuffer = Buffer.fromArray<Principal>(vetArray);
    tempBuffer.add(principal);
    vetArray := Buffer.toArray(tempBuffer);             //en el array de Vets
    return Principal.toText(principal);                 // y se retorna el principal para poder acceder luego al canister
  };

  //--------------- Funcion para crear un canister de tipo Pet ------------------------------
  public shared ({ caller }) func newPet(initData: initPetData) : async Text {
    if(Principal.isAnonymous(caller)){return "Identifíquese"};
    Cycles.add(113_846_199_230);        //FEE para crear un canister 13 846 199 230
    let miPet = await PetClass.Pet(caller, initData); // se crea un actor de tipo Pet y se le envian 5_000_000_000 cycles
    let principal = Principal.fromActor(miPet);       // se guarda el Principal del canister creado
    var tempBuffer = Buffer.fromArray<Principal>(petArray);
    tempBuffer.add(principal);
    petArray := Buffer.toArray(tempBuffer);           //en el array de Pets
    return Principal.toText(principal);               // y se retorna el principal para poder acceder luego al canister
  };

  //-----------------------------------------------------------------------------------------

  public shared func isVet(_p : Principal) : async Bool {
    for (vet in vetArray.vals()) { if (vet == _p) { return true } };
    return false;
  };

  public shared func isPet(_p: Principal): async Bool{
    for(pet in petArray.vals()) { if (pet == _p) {return true}};
    return false;
  };
  //-----------------------------------------------------------------------------------------
  public shared func getVets(): async [vetInfo]{
    var tempBuffer = Buffer.Buffer<vetInfo>(0);
    for(vet in vetArray.vals()){
      let remoteActor =  actor (Principal.toText(vet)) : actor { getInfo : shared () -> async vetInfo; };
      let info = await remoteActor.getInfo();
      tempBuffer.add(info);
    };
    return Buffer.toArray(tempBuffer);
  };

  public shared func getPets(): async [petInfo]{
    var tempBuffer = Buffer.Buffer<petInfo>(0);
    for(pet in petArray.vals()){
      let remoteActor =  actor (Principal.toText(pet)) : actor { getInfo : shared () -> async petInfo; };
      let info = await remoteActor.getInfo();
      tempBuffer.add(info);
    };
    return Buffer.toArray<petInfo>(tempBuffer);
  };

};
