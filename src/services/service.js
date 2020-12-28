import axios from 'axios'
const baseURL = 'https://api.coindesk.com/v1/bpi/'

export default axios.create({
  baseURL,
  headers: {
    'Content-Type': 'application/json'
  }
})
