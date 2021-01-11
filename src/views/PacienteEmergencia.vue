<template>
    <v-card>
        <v-card-title>
            <v-text-field
                v-model="search"
                append-icon="mdi-magnify"
                label="Search"
                single-line
                hide-details>
            </v-text-field>
        </v-card-title>
        <v-data-table
            :headers="headers"
            :items="dataGridPersona"
            :search="search">
            <template v-slot:top>
                <v-toolbar flat>
                    <v-toolbar-title>Personas</v-toolbar-title>
                    <v-divider
                        class="mx-4"
                        inset
                        vertical>
                    </v-divider>
                    <v-spacer></v-spacer>
                    <v-dialog
                        v-model="dialog"
                        max-width="800px">
                        <v-card>
                            <v-card-title>
                                <span class="headline">Registrar pacientes de emergencia</span>
                            </v-card-title>
                            <v-card-text>
                                <v-tabs
                                    v-model="tab"
                                    grow>
                                    <v-tab
                                        v-for="item in items"
                                        :key="item">
                                        {{ item }}
                                    </v-tab>
                                </v-tabs>
                                <v-tabs-items v-model="tab">
                                    <v-tab-item>
                                        <v-form>
                                            <v-container class="grey lighten-5">
                                                <v-row>
                                                    <v-col
                                                        cols="12"
                                                        sm="4"
                                                        md="4">
                                                        <v-text-field
                                                            label="Cedula del medico residente">
                                                        </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="8"
                                                        md="8">
                                                        <v-text-field
                                                            label="Apellidos y nombres">
                                                        </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="2"
                                                        md="2">
                                                        <v-select
                                                            :items="listTurnos"
                                                            label="Turno">
                                                        </v-select>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="4"
                                                        md="4">
                                                        <v-menu
                                                            ref='menu'
                                                            v-model='menu'
                                                            :close-on-content-click='false'
                                                            :return-value.sync='date'
                                                            transition="scale-transition"
                                                            offset-y
                                                            min-width='290px'>
                                                            <template v-slot:activator="{ on, attrs }">
                                                                <v-text-field
                                                                    v-model="date"
                                                                    label="Fecha"
                                                                    prepend-icon="mdi-calendar"
                                                                    readonly
                                                                    v-bind="attrs"
                                                                    v-on="on">
                                                                </v-text-field>
                                                            </template>
                                                            <v-date-picker
                                                                v-model="date"
                                                                no-title scrollable>
                                                            <v-spacer></v-spacer>
                                                            <v-btn
                                                                text
                                                                color="primary"
                                                                @click="menu = false">
                                                                Cancel
                                                            </v-btn>
                                                            <v-btn
                                                                text
                                                                color="primary"
                                                                @click="closeDatepicker">
                                                                OK
                                                            </v-btn>
                                                        </v-date-picker>
                                                    </v-menu>
                                                    </v-col>
                                                </v-row>
                                            </v-container>
                                        </v-form>
                                    </v-tab-item>
                                    <v-tab-item>
                                        <v-form>
                                            <v-container class="grey lighten-5">
                                                <v-row>
                                                    <v-col
                                                        cols="12"
                                                        sm="6"
                                                        md="6">
                                                        <v-text-field
                                                            label="Apelidos y nombres ">
                                                        </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="3"
                                                        md="3">
                                                        <v-text-field
                                                            label="cedula">
                                                        </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="3"
                                                        md="3">
                                                        <v-text-field
                                                            label="Sexo">
                                                        </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="2"
                                                        md="2">
                                                        <v-text-field
                                                            label="Edad">
                                                        </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="10"
                                                        md="10">
                                                        <v-textarea
                                                            auto-grow
                                                            label="Direccion"
                                                            rows="2"
                                                            row-height="10">
                                                        </v-textarea>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="12"
                                                        md="12">
                                                        <v-textarea
                                                            auto-grow
                                                            label="Motivo de Ingreso/Hallazgos clinicos"
                                                            rows="2"
                                                            row-height="10">
                                                        </v-textarea>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="12"
                                                        md="12">
                                                        <v-textarea
                                                            auto-grow
                                                            label="Impresión diagnostica"
                                                            rows="2"
                                                            row-height="10">
                                                        </v-textarea>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="2"
                                                        md="2">
                                                        <v-text-field
                                                            label="Dest">
                                                        </v-text-field>
                                                    </v-col>
                                                    <v-col
                                                        cols="12"
                                                        sm="10"
                                                        md="10">
                                                        <v-textarea
                                                            auto-grow
                                                            label="Observaciones"
                                                            rows="2"
                                                            row-height="10">
                                                        </v-textarea>
                                                    </v-col>
                                                </v-row>
                                            </v-container>
                                        </v-form>
                                    </v-tab-item>
                                    <v-tab-item>33</v-tab-item>
                                </v-tabs-items>
                            </v-card-text>
                        </v-card>
                    </v-dialog>
                </v-toolbar>
            </template>
            <template v-slot:item.actions="item">
                <v-icon
                    small
                    class="mr-2"
                    @click="editPersona(item)">
                    mdi-pencil
                </v-icon>
                <v-icon
                    small
                    class="mr-2"
                    @click="deleteItem(item)">
                    mdi-delete
                </v-icon>
            </template>
        </v-data-table>
    </v-card>
</template>
<script>
import personaService from '../services/personas/persona.js'
export default {
  data () {
    return {
      search: '',
      dialog: false,
      tab: null,
      menu: false,
      date: new Date().toISOString().substr(0, 10),
      items: [
        'Datos del médico', 'Datos del Paciente', 'Enfermeras'
      ],
      listTurnos: ['M', 'T', 'N'],
      headers: [
        {
          text: 'Id',
          value: 'id'
        },
        {
          text: 'Tipo',
          value: 'tipo_id'
        },
        {
          text: 'Identificación',
          value: 'identificacion'
        },
        {
          text: 'Apellidos',
          value: 'apellidos'
        },
        {
          text: 'Nombres',
          value: 'nombres'
        },
        {
          text: 'Email',
          value: 'email'
        },
        {
          text: 'Actions',
          value: 'actions',
          sortable: false
        }
      ],
      dataGridPersona: []
    }
  },
  watch: {
    dialog (val) {
      val || this.close()
    },
    dialogDelete (val) {
      val || this.closeDelete()
    }
  },
  created () {
    this.initialize()
  },
  methods: {
    close () {
      this.dialog = false
      this.$nextTick(() => {})
    },
    editPersona (item) {
      this.dialog = true
    },
    deleteItem (item) {},
    async initialize () {
      const result = await personaService.getList()
      if (result[0].isSucces) {
        this.dataGridPersona = result[0].data.data.data
      } else {
        this.dataGridPersona = []
      }
    },
    closeDatepicker () {
      this.$refs.menu.save(this.date)
    }
  }
}
</script>
