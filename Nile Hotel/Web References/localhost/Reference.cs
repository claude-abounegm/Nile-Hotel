﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// This source code was auto-generated by Microsoft.VSDesigner, Version 4.0.30319.42000.
// 
#pragma warning disable 1591

namespace Nile_Hotel.localhost {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.Xml.Serialization;
    using System.ComponentModel;
    using System.Data;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.7.2556.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="WebService1Soap", Namespace="http://tempuri.org/")]
    public partial class WebService1 : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback browseRoomsOperationCompleted;
        
        private System.Threading.SendOrPostCallback bookOperationCompleted;
        
        private System.Threading.SendOrPostCallback cancelOperationCompleted;
        
        private System.Threading.SendOrPostCallback checkOutOperationCompleted;
        
        private bool useDefaultCredentialsSetExplicitly;
        
        /// <remarks/>
        public WebService1() {
            this.Url = global::Nile_Hotel.Properties.Settings.Default.Nile_Hotel_localhost_WebService1;
            if ((this.IsLocalFileSystemWebService(this.Url) == true)) {
                this.UseDefaultCredentials = true;
                this.useDefaultCredentialsSetExplicitly = false;
            }
            else {
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        public new string Url {
            get {
                return base.Url;
            }
            set {
                if ((((this.IsLocalFileSystemWebService(base.Url) == true) 
                            && (this.useDefaultCredentialsSetExplicitly == false)) 
                            && (this.IsLocalFileSystemWebService(value) == false))) {
                    base.UseDefaultCredentials = false;
                }
                base.Url = value;
            }
        }
        
        public new bool UseDefaultCredentials {
            get {
                return base.UseDefaultCredentials;
            }
            set {
                base.UseDefaultCredentials = value;
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        /// <remarks/>
        public event browseRoomsCompletedEventHandler browseRoomsCompleted;
        
        /// <remarks/>
        public event bookCompletedEventHandler bookCompleted;
        
        /// <remarks/>
        public event cancelCompletedEventHandler cancelCompleted;
        
        /// <remarks/>
        public event checkOutCompletedEventHandler checkOutCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/browseRooms", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public System.Data.DataTable browseRooms(string dateIn, string dateOut, string roomPref) {
            object[] results = this.Invoke("browseRooms", new object[] {
                        dateIn,
                        dateOut,
                        roomPref});
            return ((System.Data.DataTable)(results[0]));
        }
        
        /// <remarks/>
        public void browseRoomsAsync(string dateIn, string dateOut, string roomPref) {
            this.browseRoomsAsync(dateIn, dateOut, roomPref, null);
        }
        
        /// <remarks/>
        public void browseRoomsAsync(string dateIn, string dateOut, string roomPref, object userState) {
            if ((this.browseRoomsOperationCompleted == null)) {
                this.browseRoomsOperationCompleted = new System.Threading.SendOrPostCallback(this.OnbrowseRoomsOperationCompleted);
            }
            this.InvokeAsync("browseRooms", new object[] {
                        dateIn,
                        dateOut,
                        roomPref}, this.browseRoomsOperationCompleted, userState);
        }
        
        private void OnbrowseRoomsOperationCompleted(object arg) {
            if ((this.browseRoomsCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.browseRoomsCompleted(this, new browseRoomsCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/book", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public int book(string guest, string roomNumber, string roomType, string season, string checkIn, string checkOut) {
            object[] results = this.Invoke("book", new object[] {
                        guest,
                        roomNumber,
                        roomType,
                        season,
                        checkIn,
                        checkOut});
            return ((int)(results[0]));
        }
        
        /// <remarks/>
        public void bookAsync(string guest, string roomNumber, string roomType, string season, string checkIn, string checkOut) {
            this.bookAsync(guest, roomNumber, roomType, season, checkIn, checkOut, null);
        }
        
        /// <remarks/>
        public void bookAsync(string guest, string roomNumber, string roomType, string season, string checkIn, string checkOut, object userState) {
            if ((this.bookOperationCompleted == null)) {
                this.bookOperationCompleted = new System.Threading.SendOrPostCallback(this.OnbookOperationCompleted);
            }
            this.InvokeAsync("book", new object[] {
                        guest,
                        roomNumber,
                        roomType,
                        season,
                        checkIn,
                        checkOut}, this.bookOperationCompleted, userState);
        }
        
        private void OnbookOperationCompleted(object arg) {
            if ((this.bookCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.bookCompleted(this, new bookCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/cancel", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public bool cancel(string refNo) {
            object[] results = this.Invoke("cancel", new object[] {
                        refNo});
            return ((bool)(results[0]));
        }
        
        /// <remarks/>
        public void cancelAsync(string refNo) {
            this.cancelAsync(refNo, null);
        }
        
        /// <remarks/>
        public void cancelAsync(string refNo, object userState) {
            if ((this.cancelOperationCompleted == null)) {
                this.cancelOperationCompleted = new System.Threading.SendOrPostCallback(this.OncancelOperationCompleted);
            }
            this.InvokeAsync("cancel", new object[] {
                        refNo}, this.cancelOperationCompleted, userState);
        }
        
        private void OncancelOperationCompleted(object arg) {
            if ((this.cancelCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.cancelCompleted(this, new cancelCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/checkOut", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public bool checkOut(string refNo) {
            object[] results = this.Invoke("checkOut", new object[] {
                        refNo});
            return ((bool)(results[0]));
        }
        
        /// <remarks/>
        public void checkOutAsync(string refNo) {
            this.checkOutAsync(refNo, null);
        }
        
        /// <remarks/>
        public void checkOutAsync(string refNo, object userState) {
            if ((this.checkOutOperationCompleted == null)) {
                this.checkOutOperationCompleted = new System.Threading.SendOrPostCallback(this.OncheckOutOperationCompleted);
            }
            this.InvokeAsync("checkOut", new object[] {
                        refNo}, this.checkOutOperationCompleted, userState);
        }
        
        private void OncheckOutOperationCompleted(object arg) {
            if ((this.checkOutCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.checkOutCompleted(this, new checkOutCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        public new void CancelAsync(object userState) {
            base.CancelAsync(userState);
        }
        
        private bool IsLocalFileSystemWebService(string url) {
            if (((url == null) 
                        || (url == string.Empty))) {
                return false;
            }
            System.Uri wsUri = new System.Uri(url);
            if (((wsUri.Port >= 1024) 
                        && (string.Compare(wsUri.Host, "localHost", System.StringComparison.OrdinalIgnoreCase) == 0))) {
                return true;
            }
            return false;
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.7.2556.0")]
    public delegate void browseRoomsCompletedEventHandler(object sender, browseRoomsCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.7.2556.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class browseRoomsCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal browseRoomsCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public System.Data.DataTable Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((System.Data.DataTable)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.7.2556.0")]
    public delegate void bookCompletedEventHandler(object sender, bookCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.7.2556.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class bookCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal bookCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public int Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((int)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.7.2556.0")]
    public delegate void cancelCompletedEventHandler(object sender, cancelCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.7.2556.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class cancelCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal cancelCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public bool Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((bool)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.7.2556.0")]
    public delegate void checkOutCompletedEventHandler(object sender, checkOutCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.7.2556.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class checkOutCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal checkOutCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public bool Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((bool)(this.results[0]));
            }
        }
    }
}

#pragma warning restore 1591