<template>
<v-card height="590px">
                <v-toolbar flat>
                  <v-toolbar-title>
                    <div class="tittle-form">
                      {{ formTitle }}
                    </div>
                  </v-toolbar-title>
                </v-toolbar>
                <v-card-text style="background:#aeaeae; padding:10px;">
                  <v-form>
                    <v-tabs fixed-tabs>
                      <v-tab>
                        Datos Personales
                      </v-tab>
                      <v-tab
                        :disabled="isDisableTabEmpleado">
                        Empleados
                      </v-tab>
                      <v-tab
                        :disabled="isDisabledTabMedico">
                        Datos médicos
                      </v-tab>

                      <v-tab-item style="height:58vh; overflow: auto;">
                      <v-card flat>
                        <v-card-text>
                          <v-container class="grey lighten-5">
                          <v-row>
                            <v-col
                                cols="12"
                                sm="3"
                                md="3">
                                <v-select
                                    v-model="persona.tipo_id"
                                    :items="nacionalidades"
                                    :error-messages="tipoIdErrors"
                                    label="Nationality"
                                    required
                                    @change="$v.persona.tipo_id.$touch()"
                                    @blur="$v.persona.tipo_id.$touch()">
                                </v-select>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="4"
                                md="4">
                                <v-text-field
                                  v-model="persona.identificacion"
                                  label="Cedula"
                                  :error-messages="identificacionErrors"
                                  :counter="10"
                                  @input="$v.persona.identificacion.$touch()"
                                  @blur="$v.persona.identificacion.$touch()">
                                </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="5"
                                md="5">
                                <v-text-field
                                  v-model="persona.nombres"
                                  label="Firts name"
                                  :error-messages="nombresErrors"
                                  :counter="255"
                                  @input="$v.persona.nombres.$touch()"
                                  @blur="$v.persona.nombres.$touch()">
                                </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="5"
                                md="5">
                                  <v-text-field
                                    v-model="persona.apellidos"
                                    label="Second Name"
                                    :error-messages="apellidosErrors"
                                    :counter="255"
                                    @input="$v.persona.apellidos.$touch()"
                                    @blur="$v.persona.apellidos.$touch()">
                                  </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="4"
                                md="4">
                                <v-menu
                                  ref='menu'
                                  v-model='menu'
                                  :close-on-content-click='false'
                                  :return-value.sync='persona.fecha_nac'
                                  transition="scale-transition"
                                  offset-y
                                  min-width='290px'>
                                  <template v-slot:activator="{ on, attrs }">
                                    <v-text-field
                                      v-model="persona.fecha_nac"
                                      label="Birthdate"
                                      prepend-icon="mdi-calendar"
                                      readonly
                                      v-bind="attrs"
                                      v-on="on">
                                    </v-text-field>
                                  </template>
                                  <v-date-picker
                                    v-model="persona.fecha_nac"
                                    no-title scrollable
                                    @click="functionEvents">
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
                              <v-col
                                cols="12"
                                sm="3"
                                md="3">
                                  <v-text-field
                                    v-model="persona.edad"
                                    label="Edad"
                                    readonly>
                                  </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="6"
                                md="6">
                                  <v-text-field
                                    v-model="persona.email"
                                    :error-messages="emailErrors"
                                    label="E-mail"
                                    required
                                    @input="$v.persona.email.$touch()"
                                    @blur="$v.persona.email.$touch()">
                                  </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="6"
                                md="6">
                                <v-select
                                  v-model="persona.tipo_persona_id "
                                  :items="dataTipoPersona"
                                  item-text="descripcion"
                                  item-value="id"
                                  label="Tipo de persona"
                                  @change="activarTabPersona">
                                </v-select>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="4"
                                md="4">
                                <v-select
                                  v-model="persona.sexo"
                                  :items="listSexo"
                                  :error-messages="sexoErrors"
                                  label="Sexo"
                                  required
                                  @change="$v.persona.sexo.$touch()"
                                  @blur="$v.persona.sexo.$touch()">
                                </v-select>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="4"
                                md="4">
                                <v-text-field
                                  v-model="persona.talla"
                                  label="Talla">
                                </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="4"
                                md="4">
                                <v-text-field
                                  v-model="persona.peso"
                                  label="Peso">
                                </v-text-field>
                              </v-col>
                              <v-col
                                cols="12"
                                sm="12"
                                md="12">
                                <v-textarea
                                  v-model="persona.direccion"
                                  auto-grow
                                  label="Direccion"
                                  rows="2"
                                  row-height="20">
                                </v-textarea>
                              </v-col>
                            </v-row>
                          </v-container>
                          </v-card-text>
                        </v-card>
                      </v-tab-item>
                      <v-tab-item style="height:58vh;overflow: auto;">
                        <v-card flat>
                          <v-card-text>
                          <v-container class="grey lighten-5">
                            <v-row>
                              <v-col
                                cols="12"
                                sm="6"
                                md="6">
                                <v-select
                                  v-model="persona.area_id"
                                  :items="dataArea"
                                  item-text="descripcion"
                                  item-value="id"
                                  label="Area">
                                </v-select>
                              </v-col>
                            </v-row>
                          </v-container>
                          </v-card-text>
                        </v-card>
                      </v-tab-item>
                      <v-tab-item style="height:58vh;overflow: auto;">
                        <v-card flat>
                          <v-card-text>
                          <v-container class="grey lighten-5">
                            <v-row>
                              <v-col
                                cols="12"
                                sm="6"
                                md="6">
                                <v-select
                                v-model="persona.especialidad_id"
                                :items="dataEspecialidad"
                                item-text="descripcion"
                                item-value="id"
                                label="Especialidad">
                              </v-select>
                            </v-col>
                          </v-row>
                        </v-container>
                        </v-card-text>
                      </v-card>
                    </v-tab-item>
                    </v-tabs>
                  </v-form>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    color="blue darken-1"
                    text
                    @click="close">
                    Cancel
                  </v-btn>
                  <v-btn
                    color="blue darken-1"
                    text
                    @click="save">
                    Save
                  </v-btn>
                </v-card-actions>
              </v-card>
  <v-row justify="center">
    <v-dialog
      v-model="dialog"
      fullscreen
      hide-overlay
      transition="dialog-bottom-transition"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          color="primary"
          dark
          v-bind="attrs"
          v-on="on"
        >
          Open Dialog
        </v-btn>
      </template>
      <v-card>
        <v-toolbar
          dark
          color="primary"
        >
          <v-btn
            icon
            dark
            @click="dialog = false"
          >
            <v-icon>mdi-close</v-icon>
          </v-btn>
          <v-toolbar-title>Settings</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-toolbar-items>
            <v-btn
              dark
              text
              @click="dialog = false"
            >
              Save
            </v-btn>
          </v-toolbar-items>
        </v-toolbar>
        <v-list
          three-line
          subheader
        >
          <v-subheader>User Controls</v-subheader>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Content filtering</v-list-item-title>
              <v-list-item-subtitle>Set the content filtering level to restrict apps that can be downloaded</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Password</v-list-item-title>
              <v-list-item-subtitle>Require password for purchase or use password to restrict purchase</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-list>
        <v-divider></v-divider>
        <v-list
          three-line
          subheader
        >
          <v-subheader>General</v-subheader>
          <v-list-item>
            <v-list-item-action>
              <v-checkbox v-model="notifications"></v-checkbox>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>Notifications</v-list-item-title>
              <v-list-item-subtitle>Notify me about updates to apps or games that I downloaded</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-action>
              <v-checkbox v-model="sound"></v-checkbox>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>Sound</v-list-item-title>
              <v-list-item-subtitle>Auto-update apps at any time. Data charges may apply</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-action>
              <v-checkbox v-model="widgets"></v-checkbox>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>Auto-add widgets</v-list-item-title>
              <v-list-item-subtitle>Automatically add home screen widgets</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-card>
    </v-dialog>
  </v-row>
</template>
<script>
export default {
  data () {
    return {
      dialog: false,
      notifications: false,
      sound: true,
      widgets: false
    }
  }
}
</script>
