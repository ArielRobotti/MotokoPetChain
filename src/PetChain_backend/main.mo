
actor {
  var name: Text = "";
  var contactPhone: ?Nat64 = null;



  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
};
