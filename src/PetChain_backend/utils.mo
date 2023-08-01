module {
    public shared ({caller})func optToPrincipal(x : ?Principal) : async Principal {
        return switch (x) {
            case (?n) { n };
            case null { caller };
        };
    };
};
