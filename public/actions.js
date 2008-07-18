jQuery.fn.clearonfocus = function() {
  jQuery(this)
      .bind('focus', function() {
          // Set the default value if it isn't set
          if ( !this.defaultValue ) this.defaultValue = this.value;
          // Check to see if the value is different
          if ( this.defaultValue && this.defaultValue != this.value ) return;
          // It isn't, so remove the text from the input
          this.value = '';
      })
      .bind('blur', function() {
          // If the value is blank, return it to the defaultValue
          if ( this.value.match(/^\s*$/) )
              this.value = this.defaultValue;
      });
};

$().ready(function(){
  $('input:text').clearonfocus();
});