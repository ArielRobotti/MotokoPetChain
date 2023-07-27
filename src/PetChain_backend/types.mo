module{
    type Client = {
        id: Nat64;
        name: Text;
        lastName: Text;
        phone: Nat64;

    };
    type Pet = {
        id: Nat64;
        name: Text;
        owner: Client;
    };
    
}
