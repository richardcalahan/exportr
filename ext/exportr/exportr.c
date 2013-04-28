#include "ruby.h"
#include "ruby/util.h"
#include <stdio.h>
#include <unistd.h>

#define FILE "exportr.yml"

static const char *d_scan[] = { "", "config", 0 };

static VALUE File = Qnil; 
static VALUE rb_file ( void )
{   
    if ( TYPE(File) == T_NIL ) {
        File = rb_const_get(rb_cObject, rb_intern("File")); 
    }
    
    return File;
}

static VALUE Yaml = Qnil;
static VALUE rb_yaml ( void )
{
    if ( TYPE(Yaml) == T_NIL ) {
        Yaml = rb_const_get(rb_cObject, rb_intern("YAML"));
    }
    
    return Yaml;
}

static VALUE exportr_config_file ( void ) 
{
    VALUE filepath, frag;
    VALUE exists = Qfalse;

    int i;
    for ( i=0; 1; i++ ) {
        if ( d_scan[i] == 0 ) break;

        frag = rb_str_new2(d_scan[i]);
        if ( strlen(d_scan[i]) > 0 ) rb_str_cat2(frag, "/");
        rb_str_cat2(frag, FILE);

        filepath = rb_funcall(rb_file(), rb_intern("expand_path"), 1, frag);
        exists = rb_funcall(rb_file(), rb_intern("exists?"), 1, filepath);

        if ( TYPE(exists) == T_TRUE ) break;

        filepath = Qnil;
    }
    
    return filepath;
}

static int exportr_set_env ( VALUE k, VALUE v, VALUE data )
{   
    if ( TYPE(v) != T_STRING ) {
        v = rb_funcall(v, rb_intern("to_s"), 0);
    }

    Check_Type(k, T_STRING);
    Check_Type(v, T_STRING);

    ruby_setenv(StringValuePtr(k), StringValuePtr(v));

    return ST_CONTINUE;
}

static VALUE exportr_read ( void )
{
    VALUE data;
    VALUE config = exportr_config_file();
    VALUE hash = Qnil;

    if ( TYPE(config) != T_NIL ) {
        data = rb_funcall(rb_file(), rb_intern("read"), 1, config);
        hash = rb_funcall(rb_yaml(), rb_intern("load"), 1, data);
        return hash;
    }    
    return Qnil;
}

static VALUE exportr_export ( void )
{
    VALUE hash = exportr_read();

    if ( TYPE(hash) == T_HASH ) {
        rb_hash_foreach(hash, *exportr_set_env, Qnil);
        return Qtrue;
    }    

    return Qfalse;
}

void Init_exportr ( void )
{
    rb_require("yaml");

    VALUE rb_mExportr;

    rb_mExportr = rb_define_module("Exportr");
    rb_define_singleton_method(rb_mExportr, "export", exportr_export, 0);
    rb_define_singleton_method(rb_mExportr, "read", exportr_read, 0);
    rb_define_singleton_method(rb_mExportr, "config_file", exportr_config_file, 0);
    
    /* 
     * Manually call read on Exportr module when lib is loaded
     */
    rb_funcall(rb_mExportr, rb_intern("export"), 0);
}
