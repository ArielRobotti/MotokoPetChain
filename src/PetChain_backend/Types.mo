module{/*
    public type Client = {
        id: Nat64;
        name: Text;
        lastName: Text;
        phone: Nat64;

    };
    public type Pet = {
        id: Nat64;
        name: Text;
        owner: Client;
    };*/
    public type Turno = {
        date: Int; //Timestamp del dia del turno 
        client: Principal; // Cuando es null el turno está disponible
    };
    public type Calendar = {
        var history: [Turno];
        var today: [Turno];
        var netxFiveDays: [[Turno]];
    };
    
}
