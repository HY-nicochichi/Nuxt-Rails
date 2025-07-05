export default defineNuxtRouteMiddleware(async(to, from) => {
  const user = useUserStore()
  const resp: Resp = await accessUserGet()

  if (resp.status === 200) {
    user.value = {
      login: true,
      email: resp.json.email,
      name: resp.json.name
    }
  }
  else {
    user.value = {
      login: false, email: '', name: ''
    }
    setJwt()
  }

  const NoAuthRoutes: string[] = ['user-auth', 'user-new']

  if (to.name !== 'index'){
    if (user.value.login && NoAuthRoutes.includes(to.name as string)) {
      return navigateTo({name: 'index'})
    }
    if (!user.value.login && !NoAuthRoutes.includes(to.name as string)) {
      return navigateTo({name: 'user-auth'})
    }
  }
})
