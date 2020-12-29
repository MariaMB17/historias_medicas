import axios from 'axios'
import authHeader from './auth-header.js'
const baseURL = 'http://api.historias/'
export default axios.create({
  baseURL,
  headers: authHeader()
})
