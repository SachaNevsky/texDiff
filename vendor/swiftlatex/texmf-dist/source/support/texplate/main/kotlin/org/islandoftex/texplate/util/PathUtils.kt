// SPDX-License-Identifier: BSD-3-Clause
package org.islandoftex.texplate.util

import java.io.FileNotFoundException
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths

/**
 * Helper methods for path handling.
 *
 * @version 1.0
 * @since 1.0
 */
object PathUtils {
    // the templates folder
    private const val TEMPLATES_FOLDER = "templates"
    // the user application folder
    private const val USER_APPLICATION_FOLDER = ".texplate"

    /**
     * The user's template path.
     */
    private val userTemplatePath: Path
        get() = try {
            Paths.get(System.getProperty("user.home"),
                    USER_APPLICATION_FOLDER, TEMPLATES_FOLDER)
        } catch (e: RuntimeException) {
            Paths.get(".")
        }

    /**
     * Searches all paths looking for the provided template.
     *
     * @param name The name to be associated to a template file.
     * @return The corresponding template file.
     * @throws FileNotFoundException The template file could not be found.
     */
    @JvmStatic
    @Throws(FileNotFoundException::class)
    fun getTemplatePath(name: String): Path {
        // the file has to be a TOML format, so we add the extension
        val fullName = "$name.toml"
        // the first reference is based on the user template path resolved with the
        // file name
        val reference = userTemplatePath.resolve(fullName)
        // if the file actually exists, the search is done!
        return if (Files.exists(reference)) {
            reference
        } else {
            // the reference was not found in the user location, so let us try the
            // system counterpart
            try {
                val tempFile = Files.createTempFile(null, null)
                tempFile.toFile().writeText(PathUtils::class.java
                        .getResource("/org/islandoftex/texplate/templates/texplate-$fullName")
                        .readText())
                tempFile
            } catch (e: RuntimeException) {
                throw FileNotFoundException("I am sorry, but the template " +
                        "file '" + fullName + "' could not be found in the " +
                        "default template locations (system and user). Make " +
                        "sure the reference is correct and try again. For " +
                        "reference, these are the paths I searched: '" +
                        userTemplatePath + "'.")
            }
        }
    }
}
