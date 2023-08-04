import Blob "mo:base/Blob";
import Buffer "mo:base/Buffer";

module{

    public type Turno = {
        date: Int; //Timestamp del dia del turno 
        client: Principal; // Cuando es null el turno está disponible
    };
    public type Calendar = {
        history: [Turno];
        today: [Turno];
        netxFiveDays: [[Turno]];
    };
    public type Clinical_record = {
        date: Int;
        sintomas: Text;
        diagnostico: Text;
        tratamiento: Text;
    };

    public type Evento ={
        date: Int; //Timestamp en segundos
        titulo: Text;
        descripcion: Text;
    };
    
    /*public func regToBlob(r : Clinical_record): async [Blob]{
        var tempBuffer = Buffer.Buffer<Blob>(1);
        tempBuffer.add(Blob.fromInt(r.date));
        tempBuffer.add(Blob.fromText(r.sintomas));
        tempBuffer.add(Blob.fromText(r.diagnostico));
        tempBuffer.add(Blob.fromText(r.tratamiento));
        return Blob.toArray(tempBuffer);
    };

    shared func regFronBlob(b: [Blob]): async Clinical_record{
        let date = Blob.toInt(b[0]);
        let sintomas = Blob.toText(b[1]);
        let diagnostico = Blob.toText(b[2]);
        let tratamiento = Blob.toText(b[3]);
        return {date; sintomas; diagnostico; tratamiento};
    };
    */
}
