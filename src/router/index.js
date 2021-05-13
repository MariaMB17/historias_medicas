import Vue from 'vue'
import moment from 'moment'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'

const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push (location) {
  return originalPush.call(this, location).catch(err => err)
}

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Login',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "register" */ '../views/Register.vue')
  },
  {
    path: '/principal/',
    name: 'Principal',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/Principal.vue'),
    meta: {
      requiresAuth: true
    },
    children: [
      {
        path: 'persona',
        name: 'Persona',
        component: () => import(/* webpackChunkName: "about" */ '../views/Persona.vue'),
        meta: {
          requiresAuth: true
        }
      },
      {
        path: 'pacienteEmergencia',
        name: 'PacienteEmergencia',
        component: () => import(/* webpackChunkName: "about" */ '../views/PacienteEmergencia.vue'),
        meta: {
          requiresAuth: true
        }
      }
    ]
  },
  {
    path: '*',
    name: 'Login',
    component: Login
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})
router.beforeEach((to, from, next) => {
  if (to.matched.some(route => { console.log(route.meta.requiresAuth); return route.meta.requiresAuth })) {
    const user = JSON.parse(localStorage.getItem('user'))
    if (user && user.access_token) {
      const now = moment(new Date(), 'YYY-MM-DD')
      const expirateToken = moment(user.expires_at, 'YYYY-MM-DD')
      const changeToken = now.isAfter(expirateToken)
      if (changeToken) {
        return next('/')
      }
      return next()
    } else {
      return next('/')
    }
  }
  next()
})
export default router
