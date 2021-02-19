import axios from 'axios'
const baseURL = 'http://back-historias.localhost/'
export default axios.create({ baseURL })
