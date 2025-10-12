Autenticação

● Todo o fluxo de autenticação deve ser usando o firebase auth e deve ser passado o
token do firebase em todas as rotas da api

Usuário

● Cadastro de usuário: POST - https://untold-strapi.api.prod.loomi.com.br/api/
auth/local/register
Exemplo de body: {
"username":"italo teste",
"email":"djdjsj@gmaip.com",
"password":"12345678",
"firebase_UID":"5loiM6TbLAaAgPAqeLDDzzif30v2"
}

● Rota de finalizar onboarding: PATCH -
https://untold-strapi.api.prod.loomi.com.br/api/users/updateMe
Exemplo de body:{
"data":{
"finished_onboarding":true
}
}

● Recuperar dados do usuário: GET -
https://untold-strapi.api.prod.loomi.com.br/api/users/me

● Atualizar dados do usuário: PATCH -
https://untold-strapi.api.prod.loomi.com.br/api/users/updateMe
Exemplo de body: {
"data":{
"username":"italo "
}
}
● Remover usuário: DELETE -
https://untold-strapi.api.prod.loomi.com.br/api/users/USER_ID

Filmes

● Recuperar filme: GET -
https://untold-strapi.api.prod.loomi.com.br/api/movies?populate=poster
● Recuperar Likes: GET -
https://untold-strapi.api.prod.loomi.com.br/api/likes?populate=*
● Dar like: POST - https://untold-strapi.api.prod.loomi.com.br/api/likes
Exemplo de body: {
"data":{
"movie_id":1,
"user_id":
}

}

● Dar deslike: DELETE - https://untold-strapi.api.prod.loomi.com.br/api/likes/LIKE_ID
● Recuperar as legendas: GET -
https://untold-strapi.api.prod.loomi.com.br/api/subtitles?populate=file&filters%5Bmovi
e_id%5D=MOVIE_ID
