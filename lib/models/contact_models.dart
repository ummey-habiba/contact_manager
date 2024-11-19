const tableContact ='tbl_contact';
const tblContactColId= 'id';
const tblContactColName= 'name';
const tblContactColMobile= 'mobile';
const tblContactColEmail= 'email';
const tblContactColGender= 'gender';
const tblContactColGroup= 'group';
const tblContactColWebsite= 'website';
const tblContactColAddress= 'address';
const tblContactColDob= 'dob';
const tblContactColImage= 'image';

class ContactModels{
  int ? id ;
  String name ;
  String email;
  String address;
  String mobile ;
  String group;
  String gender ;
  String ? image ;
  String ? website ;
  String ? dob;

  ContactModels.name({
    required this.name,
    required this.email,
    required this.address,
    required this.mobile,
    required this.group,
    required this.gender,
    this.image,
    this.website,
    this.dob,
  });

  Map<String, dynamic> toMap(){
    final map = <String,dynamic>{

      tblContactColName : name,
      tblContactColMobile : mobile,
      tblContactColEmail :email,
      tblContactColWebsite: website,
      tblContactColAddress : address,
      tblContactColImage :image,
      tblContactColDob: dob,
      tblContactColGroup : group,
      tblContactColGender :gender,
    };

    return map;
  }
}