import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams, ToastController, Events } from 'ionic-angular';
import { AppPreferences } from '@ionic-native/app-preferences';
import { CadastroPage } from '../cadastro/cadastro';
import { EnderecoPage } from '../endereco/endereco';
import { SenhaPage } from '../senha/senha';

import { Cliente } from '../../models/cliente';
import { Link } from '../../models/link';

import { LogineventProvider } from '../../providers/loginevent/loginevent';

import { Http } from '@angular/http';

import 'rxjs/add/operator/map';

/**
 * Generated class for the Login page.
 *
 * See http://ionicframework.com/docs/components/#navigation for more info
 * on Ionic pages and navigation.
 */
@IonicPage()
@Component({
  selector: 'page-login',
  templateUrl: 'login.html',
})
export class LoginPage {

  public data: any;
  public link: Link;

  email: string = '';
  senha: string = '';
  id: number;
  message: string = '';
  split: string[];
  cliente: Cliente;

  constructor(public navCtrl: NavController, public navParams: NavParams, public http: Http, private appPreferences: AppPreferences, private toastCtrl: ToastController, public loginevent: LogineventProvider) {
    this.link = new Link();
  }

  ionViewDidLoad() {
    this.appPreferences.fetch('key').then((res) => { 
      if (res != '') {
        console.log('res: ' + res);
        this.goToEndereco(res);
      }
    });
  }

  /*loginWithGoogle() {
    this.googlePlus.login({})
      .then(res => console.log(res))
      .catch(err => console.error(err));
  }*/

  login() {
    if(this.validaCampos()){
      this.http.post(this.link.api_url + 'clientes/login', {'Cliente': {'email': this.email, 'senha': this.senha}})
        .map(res => res.json())
        .subscribe(data => {       
          
          if (typeof data.message == "object") {
            this.cliente = data.message['0'];

            this.appPreferences.store('key', this.cliente['Cliente']['id'].toString()).then((res) => { 
              this.loginevent.login();
              this.goToEndereco(0);
            });

          } else {
            this.toast(data.message);
          }
      });
     } else {
       let toast = this.toastCtrl.create({
        message: "Preencha os campos, por gentileza",
        duration: 3000,
        position: 'top'
      });
      toast.present();
     }
  }

  validaCampos() {
    if (this.email == "" || this.senha == "") {
      return false;
    }
    return true;
  }

  goToCadastro() {     
  	this.navCtrl.push(CadastroPage);   
  }

  goToEndereco(id: number) {     
    if (id != 0) {
      this.navCtrl.setRoot(EnderecoPage, {cliente: id});
    } else {
  	  this.navCtrl.setRoot(EnderecoPage, {cliente: this.cliente});
    }
  }

  recuperarSenha() {
    this.navCtrl.push(SenhaPage);
  }

  toast(cod: Number) {
    if (cod == -1) {
      let toast = this.toastCtrl.create({
        message: "Login/Senha incorretos!",
        duration: 3000,
        position: 'top'
      });
      toast.present();
    } else if (cod == -10) {
      let toast = this.toastCtrl.create({
        message: "Ocorreu algum erro, tente novamente",
        duration: 3000,
        position: 'top'
      });
      toast.present();
    } 
  }

}
