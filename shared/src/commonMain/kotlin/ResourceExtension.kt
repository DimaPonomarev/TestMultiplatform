
import dev.icerock.moko.resources.StringResource
import dev.icerock.moko.resources.desc.Resource
import dev.icerock.moko.resources.desc.StringDesc

class ResourceExtension {
    fun getStringDesc(id: StringResource): StringDesc {
        return StringDesc.Resource(id)
    }
}