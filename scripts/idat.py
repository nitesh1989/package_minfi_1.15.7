class Idat( Binary ):
    """Binary data in idat format"""
    file_ext = "idat"

    def __init__( self, **kwd ):
        Binary.__init__( self, **kwd )

    def sniff( self, filename ):
        try:
            header = open( filename ).read(4)
            if binascii.b2a_hex( header ) == binascii.hexlify( 'IDAT' ):
                return True
            return False
        except:
            return False

Binary.register_sniffable_binary_format("idat", "idat", Idat)