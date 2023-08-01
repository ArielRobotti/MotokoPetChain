import PetClass "PetClass";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";
import Cycles "mo:base/ExperimentalCycles";
import List "mo:base/List";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Types "Types";
import Array "mo:base/Array";

type Turno = Types.Turno;

actor {
  
  stable var petList = List.nil<Principal>(); //Lista de historias clinicas iniciadas por esta veterinaria
  stable var calendarioTurnos = Array.init<?Principal>(40, null);

  // Esta funcion crea una nueva historia clinica cuyo control será compartido por el dueño de la mascota (caller)
  public shared ({ caller }) func newPet(_name : Text) : async Principal {
    //FEE 13846199230
    Cycles.add(13846199230);
    let miPet = await PetClass.Pet(caller, "", "", "", "", "", 0, ""); // se instancia un actor de tipo Pet
    let principal = Principal.fromActor(miPet); // se guarda el Principal del canister creado
    petList := List.push(principal, petList); // en la lista de Pets
    return principal; // y se retorna el principal para poder acceder luego al canister
  };

  public query func getMiPets() : async [Principal] {
    List.toArray<Principal>(petList);
  };

  public shared ({ caller }) func getInfoFromPrincipal(principal : Text) : async [Text] {
    let remotePet = actor (principal) : actor {
      getInfo : shared () -> async [Text];
    };
    await remotePet.getInfo();
  };

  public shared func turnosDisponibles() : async [Turno] {

    [];
  };

  /*
  public shared ({caller}) func findByEmailOrPhone(e: Text):async (Principal, [Text]){

    if(Text.contains(e, #char '@')){
      for(p: Principal in Iter.fromList<Principal>(petList)){

      };
    };
    return (caller, []);
  };
  */
};
