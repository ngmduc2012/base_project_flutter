class UserQuery {
  static const login = """
        query Login (\$email: String!, \$password:String!){
          login (email: \$email, password: \$password) {
                    accessToken,
            avatar,
            avatarBase64{
                path,
                data
            },
            fullName,
            email,
            Department{
                name,
                id
            },
            birthDay
            gender,
            phoneNumber,
            Company{
                name,
                id,
            },
            faceImagesArrayBase64{
                id,
                userId,
                faceImageType,
                path,
                data
            },
            id,
            dateCreated,
            dateModified,
            status
    }
}
  """;

}
