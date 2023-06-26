class Usuario {

   late final int dni;
   late final String name;
   late final String lastname;
   late final String email;
   late final String details;

   Usuario({
      required this.dni,
      required this.name,
      required this.lastname,
      required this.email,
      required this.details,
   });

   factory Usuario.fromJson(Map<String, dynamic> json) {
         return Usuario(
            dni: json['dni'] ,
            name: json['name'] ,
            lastname: json['lastname'],
            email: json['email'] ,
            details: json['details'],
         );
   }

   Map<String, dynamic> toJson() {
      return {
         'dni': dni,
         'name': name,
         'lastname': lastname,
         'email': email,
         'details': details,
      };
   }

}
