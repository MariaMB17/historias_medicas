import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'

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
  if (to.matched.some(route => route.meta.requiresAuth)) {
    const user = JSON.parse(localStorage.getItem('user'))
    if (user && user.access_token) {
      return next()
    } else {
      return next('/')
    }
  }
  next()
})
export default router
