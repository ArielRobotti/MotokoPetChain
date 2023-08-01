module{
    public type eventosDiarios = {
        timestamp: Nat;
        titulo: Text;
        descripcion: Text;
    };

    public type eventosClinicos = {
        timestamp: Nat;
        sintomas: Text;
        diagnostico: Text;
        tratamiento: Text;
        nuevoTurno: Turno;
    };

    public type Turno = {
        timestamp: Nat;
    };
    
}
